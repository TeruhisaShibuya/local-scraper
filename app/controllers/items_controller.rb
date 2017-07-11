class ItemsController < ApplicationController
  
  #nokogiriスタート！
  def new
    require 'open-uri' 
    require 'nokogiri'
    
    #ジミーチュウの場合https://www.antonia.it/221_jimmy-choo
    #ルブタンの場合https://www.antonia.it/153_christian-louboutin
    url = 'https://www.antonia.it/221_jimmy-choo'

    charset = nil
  
    html = open(url) do |f|
      charset = f.charset   
      f.read   
    end #13のend

    doc = Nokogiri::HTML.parse(html, nil, charset) 

    #ルブタンのxpathは→ 　　　　//*[@id="womanList"]
    #ジミーチュウのxpathは→　　 //*[@id="womanListSale"]
    crawlp = doc.xpath('//*[@id="womanListSale"]')

    crawlp.css('a').css('img').each do |f|
      image = f.attribute('src').value
      url = f.parent.attribute('href').value

        @news = Item.new(:item_url => url, :image_url=> image )
        @news.save
        #p '-------------------------'
        #p news
        #p '-------------------------'
    end
  end


  #更新情報を受け取るアクション
  def update    

    #Dateクラスを用意・日付を指定
    require "date"
    old_day = Date.new(2017, 6, 26)
    new_day = Date.new(2017, 7, 9)  
    
    #whereでそれぞれの日のレコードを取得
    old_crawls = Item.where(created_at: old_day.all_day)
    @past_ins = old_crawls
    new_crawls = Item.where(created_at: new_day.all_day)

    #image_urlカラムの情報を取得
    #past_crawli = past_crawl.pluck(:image_url)
    #new_crawli = new_crawl.pluck(:image_url)


    #viewに渡す
    #@new_in = today_crawli - past_crawli 


    #戎島さんの記述
    @new_ins = [] #空の配列を用意
    new_crawls.each do |new_crawl|
      is_duplication = false
        old_crawls.each do |old_crawl|
          if new_crawl.image_url == old_crawl.image_url && new_crawl.item_url == old_crawl.item_url #カラムの比較
            is_duplication = true # 重複であると認識する
            break
          end
        end
          if is_duplication == false # 新作の場合
            @new_ins << new_crawl
          end
    end
    
  end




    #past_crawl.each do |x|
    #past_crawli = x.image_url
    #puts past_crawli
    


    #@past_crawl = past_crawl
    #@today_crawl = today_crawl
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

  #end


  def index
  	@news = Item.all
    @news = Item.page(params[:page])  #kaminariの定型文

  end

end
