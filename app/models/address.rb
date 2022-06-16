class Address < ApplicationRecord
    has_one :order 
    belongs_to :user
    
    validates :address_1, :address_2, :city, :state, :country, :zipcode, :user_id, presence: true
end
