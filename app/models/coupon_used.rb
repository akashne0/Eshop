class CouponUsed < ApplicationRecord
  belongs_to :coupon, optional: true
  belongs_to :user, optional: true
  belongs_to :order, optional: true
end
