class SitesController < ApplicationController
    
  #動作OK
  def new
    @site = Site.new
  end
  
  #動作OK
  def create
    @site = Site.new(site_params)
    if @site.save
      flash[:success] = "#{@site.name}をスクレイピング対象に加えました"
      redirect_to root_path
    else
      flash[:danger] = "入力が正しく無い項目があります"
      redirect_to :action => "new"
    end
  end

  def index
      @site = Site.all
      @site = Site.page(params[:page])
  end

  def edit
    @site = Site.find(params[:id])
  end
  
  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(site_params)
      flash[:success] = "#{@site.name}の登録情報を変更しました"
      redirect_to sites_path
    else
      flash[:danger] = "入力が正しく無い項目があります"
      redirect_to :action => "edit"
    end
  end
  
  
  private
  
  #３つのパラメータの受取を許可
  def site_params
      params.require(:site).permit(:name, :url, :crawl)
  end
  
end
