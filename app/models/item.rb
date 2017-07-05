class Item < ApplicationRecord
    validates :item_url, presence:true
    validates :image_url, presence:true
    paginates_per 40  #kaminariでの1ページあたりの表示アイテム数
end