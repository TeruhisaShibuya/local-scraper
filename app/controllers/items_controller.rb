class ItemsController < ApplicationController
  
  #nokogiriスタート！
  def new
    require 'open-uri' 
    require 'nokogiri'

    url = 'https://www.antonia.it/153_christian-louboutin'

    charset = nil
  
    html = open(url) do |f|
      charset = f.charset   
      f.read   
    end #12のend

    doc = Nokogiri::HTML.parse(html, nil, charset) 


    crawlp = doc.xpath('//*[@id="womanList"]')

    crawlp.css('a').css('img').each do |f|
      image = f.attribute('src').value
      url = f.parent.attribute('href').value
      p image
      p url
      #binding.pry
      @new = Item.new(:item_url => url, :image_url=> image )
      @new.save
    end
  end


  #更新情報を受け取るアクション
  def update    

    #Dteクラスを用意・日付を指定
    require "date"
    past_day = Date.new(2017, 6, 26)
    new_day = Date.new(2017, 7, 5)  
    
    past_crawl = Item.where(created_at: past_day.all_day)
    today_crawl = Item.where(created_at: new_day.all_day)

    @past_crawl = past_crawl
    @today_crawl = today_crawl
    #p past_crawl
    #puts today_crawl

    #@past_crawl = past_crawl
    
    #比較用に書く変数のimage_urlの値を変数に入れておく
    #past_image = past.imaga_url
    #today_image = today_crawl.imaga_url
    
    #today_crawl.image_url = today_crawli
    #past_crawl.image_url = past_crawli

    #today_crawli.each do |x|
     # unless x.include(past_crawli) then
      # @new_in  = today_crawl
      #end
    #end

  end


  def index
  	@new = Item.all
    @new = Item.page(params[:page])  #kaminariの定型文

  end

end
