class PostsController < ApplicationController

  def new
    @user = current_user
    @post = Post.new
  end

  def index
    @user = current_user
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

    @post.twitter_client

    # @post.get_tweet

    # @post = twitter_client.user_timeline(user_id: id, count: 1, exclude_replies: false, include_rts: false, contributor_details: false, result_type: "recent", locale: "ja", tweet_mode: "extended")

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

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_SECRET']
      
    end
  end

end
