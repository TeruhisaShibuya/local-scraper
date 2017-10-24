class SitesController < ApplicationController


  def new
    @site = Site.new
  end

  #submitボタンを押した後の動作
  def create
    #siteモデルのparamsを引数にnewメソッドを使用 インスタンス変数に代入
    @site = Site.new(site_params)
    #保存後の動作を記入 flashメッセージを使用する 文字列内の式展開の記述に注意
    if @site.save
      flash[:success] = "#{@site.name}をスクレイピング対象に加えました"
      redirect_to root_path
    else
      #ヴァージョンが変わってdangerに変わりました！
      flash[:danger] = "入力が正しく無い項目があります"
      #redirect/to の書き方に注意
      redirect_to :action => "new"
    end
  end

  def index
    #インスタンス変数にsiteモデルを全て代入
    @site = Site.all
    #kaminari使用時のページ遷移記述
    @site = Site.page(params[:page])
  end

  def edit
    #ruby onrailsにおいてモデルの管理はidにより行うのが一般的
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

  def destroy
    Site.find(params[:id]).destroy
    #注意の分はwarningでヴァージョンが変わってもそのまま
    flash[:warning] = "登録サイトを削除しました"
    redirect_to sites_path
  end


  private
  #フォームの値をセキュリティを保ちつつ受け取る際はprivete以下に記載する
  #３つのパラメータの受取を許可
  def site_params
      params.require(:site).permit(:name, :url, :crawl)
  end

end
