class Coupon < ApplicationRecord
    belongs_to :order, optional: true
    validates :code, uniqueness: true  
end
