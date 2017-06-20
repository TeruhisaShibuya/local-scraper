require 'open-url'
require 'nokogiri'
#スクレイピング先のURLを指定
url = https://www.sigrun-woehr.com/en/By-Brand/Gucci/

#決まり文句登場
charset = nil
html = open(url) do |f|
  charset = f.charset #文字種別を取得
  f.read #htmlを読み込んで変数htmlに渡す
 end

#docというオブジェクトを作成 中身HTML
doc = Nokogiri::HTML.parse(html, nil, charset)

p doc.title
#表示したい内容 doc.○○ で表示
#z = doc.xpath('//*[@id="wrapper"]/div/div/div[2]')