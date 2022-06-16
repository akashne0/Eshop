class Coupon < ApplicationRecord
    belongs_to :order, optional: true
    has_many :coupon_useds
    validates :code, uniqueness: true  
end
