class Contact < ApplicationRecord

    validates :name, :mobile_no, :email, :message,  presence: true
end
