class Wishlist < ApplicationRecord
  belongs_to :products, optional: true
  belongs_to :user
end
