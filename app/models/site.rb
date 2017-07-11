class Site < ApplicationRecord
    validates :name, presence:true, length: {maximum: 15}
    validates :url, presence:true
    validates :crawl, presence:true
    paginates_per 10 #1ページあたり10項目表示
end