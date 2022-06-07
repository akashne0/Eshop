class User < ApplicationRecord
  has_many :addresses
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :twitter, :facebook]

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
