namespace :itemtest do
  #実装処理
  desc "商品画像のスクレイピングテスト・サイトantonia編"
  task populate: :environment do

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
    @new = Item.new(:item_url => url, :image_url=> image )
    @new.save
  end #22のend
  end #4のend
 end #1のend