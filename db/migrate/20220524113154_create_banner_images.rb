class CreateBannerImages < ActiveRecord::Migration[6.1]
  def change
    create_table :banner_images do |t|
        
      t.timestamps
    end
  end
end
