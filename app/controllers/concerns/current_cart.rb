module CurrentCart
    extend ActiveSupport::Concern

    private
    def set_cart
        @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        @cart = Cart.create
        session[:cart_id] = @cart.id
    end

    def set_wishlist
        @wishlist = Wishlist.find(session[:wishlist_id])
    rescue ActiveRecord::RecordNotFound
        @wishlist = Wishlist.create
        session[:wishlist_id] = @wishlist.id
    end
end