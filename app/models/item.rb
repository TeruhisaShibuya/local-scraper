class Item < ApplicationRecord
    validates :item_url, presence:true
    validates :image_url, presence:true
    validates :brands, presence:true
end
