namespace :order do 
    task :daily => :environment do
        @orders_created = Order.where("created_at::date = ?", Date.today - 1)
        puts "The total number of user count is #{@orders_created.count}."    
        DailyOrdersMailer.send_consolidated_order(@orders_created).deliver
    end
end

