namespace :user do 
    task :weekly => :environment do
        @users_wishlist =  User.where.not(created_at: nil)
        puts "The total number of user count is #{@users_wishlist.count}."    
        WeeklyWishlistMailer.send_users_wishlist(@users_wishlist).deliver
    end
end

