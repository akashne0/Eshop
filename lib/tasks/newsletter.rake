namespace :newsletter do 
    task :daily => :environment do
        @newsletter_users = Newsletter.where.not(confirmed_at: nil)
        puts "The total number of user count is #{@newsletter_users.count}."
        
        @newsletter_users.each do |newsletter_user|
            if newsletter_user.subscription_type == "Daily"
                difference_in_hour = Time.now.hour - newsletter_user.updated_at.hour
                if difference_in_hour >= 6
                    puts "send mail hour"
                    NewsletterProductMailer.send_subscribed_product_details(newsletter_user).deliver
                else
                    puts "The time is less than 24hr."
                end                
            end
        end

    end

    task :weekly => :environment do
        @newsletter_users = Newsletter.where.not(confirmed_at: nil)
        puts "The total number of user count is #{@newsletter_users.count}."
        
        @newsletter_users.each do |newsletter_user|
            if newsletter_user.subscription_type == "weekly"
                difference_in_hour = Time.now.hour - newsletter_user.updated_at.hour
                if difference_in_hour >= 24  
                    puts "send mail hour"
                    NewsletterProductMailer.send_subscribed_product_details(newsletter_user).deliver
                else
                    puts "The time is less than 24hr."
                end                
            end
        end

    end
end


