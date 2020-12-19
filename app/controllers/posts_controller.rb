class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = '掲示板に書き込みました。'
      redirect_to posts_path
    else
      flash[:danger] = '書き込みに失敗しました。'
      render :index
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_back(fallback_location: posts_path)
  end


  private

  def post_params
    params[:post].permit(:content)
  end
end
