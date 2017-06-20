class ItemsController < ApplicationController
  def new
    #ノコギリの事をここに記入！
    
    #nokogiri準備
    require 'open-uri'
    require 'nokogiri'
    
    #siteモデルを全て用意してsitesに代入
    sites = Site.all
    
    #siteモデル全てに対して
    sites.each do |site|
    charset = nil
        
    site_url = site.url
    site_crawl = site.crawl
        
    #siteモデルのurlカラムを用いて、全てのページモデルのHTMLをdocに格納
    html = open(site_url) do |x|
      charset = x.charset
      x.read
    end #19行目のend 3行上ね
        
    doc = Nokogiri::HTML.parse(html, nil, charset)
        
    #crawlカラムを使用して、クロールするHTML部分を抽出する
    doc.css('.' + site_crawl).each do |y|
      puts y
    end
  end

  def update
    
  end
  
end
