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
    
    # 投稿者の名前を入れる
    @post.name = current_user.name



    if current_user.twitter_id.nil?
      # ゲストログインは禊を生成しない予定だが、一旦入れておく
      @post.ablution = 'こちらはゲストログインしています'
    else
      # binding.pry
      # @post.ablution = twitter_client.follow(current_user.twitter_id)
      # twitter_client.user_timeline(user_id: current_user.twitter_id, count: 1, exclude_replies: false, include_rts: false, contributor_details: false, result_type: "recent", locale: "ja", tweet_mode: "extended").each do |tweet|
        #puts tweet.full_text

      # 直近のツイートでもらっているいいね数の合計を取得
      twitter_client.user_timeline(user_id: current_user.twitter_id, count: 1).each do |tweet|
        @iine = 0
        @iine += tweet.favorite_count
      end

      # 直近のツイートのネガティブ度を測定

      @tweet_aggregation = ''
      twitter_client.user_timeline(user_id: current_user.twitter_id, count: 5).each do |tweet|
        # tweet_aggregation <<  tweet.full_text.gsub(/(\r\n?|\n)/,"")
        @tweet_aggregation <<  tweet.full_text.encode('SJIS', 'UTF-8', invalid: :replace, undef: :replace, replace: '').encode('UTF-8').gsub(/[0-9A-Za-z]/, '')
      end
      # binding.pry
      tweet = Post.new(ablution: @tweet_aggregation)
      tweet.tweet_diagnose
      nagative = tweet.score
      # binding.pry
      # @tweet_aggregation.tweet_diagnose
      # @post.ablution = @tweet_aggregation.tweet_diagnose
      @post.ablution = "ツイートのネガティブ度：#{nagative}"








        # テスト用に禊文章をいれておく
        # @post.get_ablution
        # @post.ablution = tweet.full_text

        # その人がしているいいね数　最大1000件
        # favorites = twitter_client.favorites(count: 1).count.to_s
        # その人がフォローしている人の数
        # followers = twitter_client.followers(count: 1).count.to_s

        # @post.ablution = "いいね数：#{favorites}　フォロー数：#{followers}　もらったいいね数：#{@iine}"
        # @post.ablution = "もらったいいね数：#{@iine}"
        # @post.ablution = 
    end




    if @post.save
      redirect_to result_path(@post.id), success: '投稿が成功しました。'
    else
      flash.now[:alert] = '投稿が失敗しました。'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :name, :score) 
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      # binding.pry
    end
  end

end
