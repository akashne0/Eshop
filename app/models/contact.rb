class Contact < ApplicationRecord
    has_rich_text :message
    validates :name, :contact_no, :email, :message,  presence: true

    after_create_commit :send_admin_notification
    after_update :send_user_notification

    def send_admin_notification
        ContactAdminNotifierMailer.admin_contact_notification(email, name, contact_no, message).deliver
    end

    def send_user_notification
        ContactUserNotifierMailer.user_contact_notification(email, name, contact_no, message, admin_note).deliver
    end

end
