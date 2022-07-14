class User < ApplicationRecord
  # acts_as_paranoid
  enum status: {enable: 0, disabled: 1}
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :refunds, dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :twitter, :facebook]

  after_create :send_user_notification unless :twitter
  after_create :send_admin_notification

  def active_for_authentication?
   super && !disabled?
  end

  def inactive_message
     !disabled? ? super : :account_inactive
  end

  def send_user_notification
    UserNotifierMailer.user_creation_notification(email, password).deliver
  end

  def send_admin_notification
    UserCreateAdminNotifierMailer.user_creation_admin_notification(email).deliver
  end

  # for adding stripe customer id to user
  def to_s
    email
  end

  after_create do
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :stripe_secret_key)
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end

  # for omni auth
  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create  do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = provider_data.info.name
    end
  end

  def email_required?
    false
  end

end
