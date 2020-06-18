class BasesController < ApplicationController
  
  def new
  end
  
  def index
    @bases = Base.all
    @base = Base.new
  end
  
  def update
    @base = Base.find(params[:id])
    if params[:base][:base_number].blank? || params[:base][:base_name].blank? || params[:base][:base_format].blank? 
      flash[:danger] = '拠点情報修正に失敗しました。'
    else
      if params[:base][:base_format] != "出勤" && params[:base][:base_format] != "退勤"
        flash[:danger] = '拠点種類は出勤または退勤にしてください。'
      elsif @base.update(base_params)
        flash[:success] = '拠点情報修正に成功しました。'
      else
        flash[:danger] = '拠点情報修正に失敗しました。'
      end
    end
    redirect_to bases_url
  end
  
  def edit
     @base = Base.find(params[:id])
  end
  
  def destroy
    @base = Base.find(params[:id])
    @base.destroy
    redirect_to bases_url
    flash[:success] = "拠点を削除しました。"
  end
  
  def create
    @base = Base.new(base_params)
    if params[:base][:base_number].blank? || params[:base][:base_name].blank? || params[:base][:base_format].blank? 
      flash[:danger] = '新規作成に失敗しました。'
    else
      if params[:base][:base_format] != "出勤" && params[:base][:base_format] != "退勤"
        flash[:danger] = '拠点種類は出勤または退勤にしてください。'
      elsif @base.save
        flash[:success] = '新規作成に成功しました。'
      else
        flash[:danger] = '新規作成に失敗しました。'
      end
    end
    redirect_to bases_url
  end
  
  private

    def base_params
      params.require(:base).permit(:base_number, :base_name, :base_format)
    end
end
