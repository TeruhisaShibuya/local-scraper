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

  def update
  end

  def index
  	@new = Item.all
  end

end
