namespace :crawls do
  #定型文
  desc "1日/回のクローリング実行タスク"
  task regular_c: :environment do
  
    require 'open-uri' 
    require 'nokogiri'
    
    sites = Site.all
    sites.each do |site|
      charset = nil

      html = open(site.url) do |url_column|  #site.urlでurlカラムを呼び出せる
        charset = url_column.charset   
        url_column.read   
      end #open(site.url)のend
      p "1"    
      doc = Nokogiri::HTML.parse(html, nil, charset) 

      crawl_points = doc.xpath("#{site.crawl}")
      p "2"
      scraiping_targets = crawl_points.css('a').css('img')
      scraiping_targets.each do |scraping_target|
        image = scraping_target.attribute('src').value
        url = scraping_target.parent.attribute('href').value

        @news = Item.new(:item_url => url, :image_url=> image )
        p @news
        
      end #scraping_targets.eachのend

    end #sites.eachのend  @newsは回すサイト一つ一つ対して保存しなくてはならないぞ！

   end #4行目environmntのend
end #1行目のend