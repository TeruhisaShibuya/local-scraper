require 'open-uri'
require 'nokogiri'
#スクレイピング先のURLを指定
url = 'https://www.antonia.it/153_christian-louboutin'

#決まり文句登場
charset = nil
html = open(url) do |f|
  charset = f.charset #文字種別を取得
  f.read #htmlを読み込んで変数htmlに渡す
 end

#docというオブジェクトを作成 中身HTML
doc = Nokogiri::HTML.parse(html, nil, charset)

#表示したい内容 doc.○○ で表示
#base = doc.xpath('//*[@id="wrapper"]/div/div/div[2]')


#xpathの書き方

crawlp = doc.xpath('//*[@id="womanList"]')

#p crawlp



#これで指定ポイントの全ての画像url部分は取れている
#p crawlp.css('a').css('img')


#最初の画像のurlの値だけ返す
#最初だけになってしまう
#p crawlp.css('a').css('img').attribute('src')


#最初の画像のurlの値だけ返す→OK
#p crawlp.css('a').css('img').attribute('src').value


#画像の取得は終了
#crawlp.css('a').css('img').each do |f|
# image = f.attribute('src').value
# p image
#end

#画像のリンクURLの取得
#crawlp.css('a').each do |f|
# url = f.attribute('href').value
# p url
#end

#画像とリンクURLの保存

crawlp.css('a').css('img').each do |f|
 image = f.attribute('src').value
 url = f.parent.attribute('href').value
 
 @new = Item.new(:link_url => url, :image_url=> image )
 @new.save
 
end







#p crawlp.css('a').css('href').attribute('src')



#p crawlp.css('a')
