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


p doc.xpath('//*[@id="womanList"]/li[1]/div/div[1]/div/a[1]/img')

p parent.doc.xpath('//*[@id="womanList"]/li[1]/div/div[1]/div/a[1]/img')





#image = base.css('img').attribute('src').value

#p image
