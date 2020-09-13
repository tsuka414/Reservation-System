class Users::SelfCategoriesController < ApplicationController
  before_action :find_user, only: %i[new create]
  before_action :logged_in_user, only: %i[new create]
  before_action :correct_user_for_child_controller, only: %i[new create]

  def new
    @category = Category.new
    @settings_class = ""
    @images_class = ""
    @category_class = "active"
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "新しい収支カテゴリを登録しました。"
      redirect_to(new_user_self_categories_url)
    else
      flash.now[:danger] = "エラーが発生しました。時間をおいてもう一度実行してみてください。"
      render("users/self_categories#new")
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :color, :user_id)
  end
end
