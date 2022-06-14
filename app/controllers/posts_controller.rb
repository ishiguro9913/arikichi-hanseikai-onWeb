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

      # 直近のツイートでもらっているいいね数の合計を取得------------------------------------------------ 
      twitter_client.user_timeline(user_id: current_user.twitter_id, count: 1).each do |tweet|
        @iine = 0
        @iine += tweet.favorite_count
      end
      # -----------------------------------------------------------------------------------------

      # 直近のツイートのネガティブ度を測定 ------------------------------------------------
      @tweet_aggregation = ''
      twitter_client.user_timeline(user_id: current_user.twitter_id, count: 5).each do |tweet|
        @tweet_aggregation <<  tweet.full_text.encode('SJIS', 'UTF-8', invalid: :replace, undef: :replace, replace: '').encode('UTF-8').gsub(/[0-9A-Za-z]/, '')
      end
      tweet = Post.new(ablution: @tweet_aggregation)
      tweet.tweet_diagnose
      nagative = tweet.score
      # binding.pry
      # @tweet_aggregation.tweet_diagnose
      # @post.ablution = @tweet_aggregation.tweet_diagnose
      @post.ablution = "ツイートのネガティブ度：#{nagative}"

      # ------------------------------------------------------------------------------ 


      # 直近の5ツイートの投稿時間からツイートの頻度を計測--------------------
      tweet_frequency = Array.new
      tweet_variance = Array.new

      # 直近のツイートの投稿時間を配列へ
      twitter_client.user_timeline(user_id: current_user.twitter_id, count: 5).each do |tweet|
        tweet_frequency <<  tweet.created_at
      end

      # 各ツイートの投稿の間隔を配列へ
      for i in 1..tweet_frequency.length-1
        tweet_variance << tweet_frequency[i] - tweet_frequency[i-1]
      end

      # 投稿時間の標準偏差を出す
      variance = stdev(tweet_variance).round
      @post.ablution = "ツイートの頻度は#{variance}"

      # --------------------------------------------------------------



      # その人がしているいいね数を取得　最大1000件? ------------------------------------------------
      # favorites = twitter_client.favorites(count: 1).count.to_s
      # @post.ablution = "過去にしてきたいいね数 #{favorites}"
      # ------------------------------------------------------------------------------------

      # その人がフォローしている人の数 -----------------------------------------------------------
      # followers = twitter_client.followers(count: 1).count.to_s
      # ------------------------------------------------------------------------------------


      # 今までの総ツイート数 -----------------------------------------------------------
      # ツイッターをやっている年数とかも考慮した方がいいか悩み中
      tweet_total = twitter_client.user(current_user.twitter_id.to_i).tweets_count
      since = twitter_client.user(current_user.twitter_id.to_i).created_at
      now = Time.now
      period = (now - since).divmod(86400).each_slice(2).map { |day, sec_r| (Time.parse("1/1") + sec_r).strftime("#{day}日") }.first
      @post.ablution = "ツイートした数：#{tweet_total} ツイッター歴：#{period}" 
      # -----------------------------------------------------------------------------
    end




    if @post.save
      redirect_to result_path(@post.id), success: '投稿が成功しました。'
    else
      flash.now[:alert] = '投稿が失敗しました。'
      render :new
    end
  end

  def average(ary)
    return ary.sum.to_f / ary.length
  end
  
  # 偏差
  def dev(ary, value)
    return value - average(ary)
  end
  
  # 偏差平方
  def devsq(ary, value)
    return dev(ary, value) ** 2
  end
  
  # 偏差平方和
  def devsqsum(ary)
    return ary.collect{|n| devsq(ary, n)}.sum
  end
  
  # 分散
  def variance(ary)
    return devsqsum(ary) / ary.length
  end
  
  # 標準偏差
  def stdev(ary)
    # Math.sqrtメソッドで平方根を計算できる
    Math.sqrt(variance(ary))
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
