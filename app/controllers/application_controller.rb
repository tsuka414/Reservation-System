class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # before actions
  def logged_in_user
    return if logged_in?

    flash[:danger] = "この操作にはログインが必要です。"
    redirect_to(login_url)
  end

  # Usersコントローラーの子コントローラー用メソッド(user_idを取る)
  def find_user
    @user = User.find(params[:user_id])
  end

  def correct_user_for_child_controller
    redirect_to(root_url) unless current_user?(@user)
  end

  def user_images_params
    params.require(:user).permit(:img, :header_image)
  end
end
