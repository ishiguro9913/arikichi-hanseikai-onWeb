class PostsController < ApplicationController

  def new
    #auto_login(current_user)
    # binding.pry
    @user = current_user
    # binding.pry
    @post = Post.new
  end

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @post = current_user.posts.build(post_params)

    # 反省文を採点する
    @post.get_sentiment

    # テスト用に禊文章をいれておく
    @post.ablution = 'テスト用の禊文章です'
    @post.get_ablution

    # 投稿者の名前を入れる
    @post.name = current_user.name

    if @post.save
      redirect_to result_path(@post.id), success: '投稿が成功しました。'
    else
      flash.now[:alert] = 'メッセージを入力してください。'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :name, :score) 
  end

end
