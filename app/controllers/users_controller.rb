class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.img = "default_img.png"
    @user.header_image = "default_header_image.png"
    if @user.save
      log_in(@user)
      flash[:success] = "ようこそ！ #{@user.name}さん！"
      redirect_to(root_url)
    else
      render("new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    @settings_class = "active"
    @images_class = ""
    @category_class = ""
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "基本情報を更新しました。"
      redirect_to(edit_user_path(@user))
    else
      render("settings_edit")
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
