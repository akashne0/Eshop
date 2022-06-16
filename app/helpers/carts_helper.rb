module CartsHelper
    # def get_addresses
    #     ["A-304 Golden Park", "C-401 Diamond Tower"]
    # end

    def get_user_addresses
        addresses = Array.new
        if user_signed_in?
            current_user.addresses.each do |address|             
                addresses << ["#{address.address_1}, #{address.address_2}, #{address.city}, #{address.state}", address.id]
            end
        end
        addresses
    end
end
