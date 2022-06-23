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

    # @post = current_user.posts.build(post_params(@current_user.id))

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
      # serch_tweet = 5
      # get_liked = 0
      # twitter_client.user_timeline(user_id: current_user.twitter_id, count: serch_tweet).each_with_index do |tweet, i|
      #   get_liked += tweet.favorite_count
      #   # @post.ablution = "直近でもらったいいね数：#{get_liked}" if i == serch_tweet - 1 
      # end

      # if 0 === get_liked then 
      #   puts '創造性評価：１'
      # elsif (1..5) === get_liked then 
      #   puts '創造性評価：２'
      # elsif (6..15) === get_liked then 
      #   puts '創造性評価：３'
      # elsif (16..25) === get_liked then 
      #   puts '創造性評価：４'
      # elsif 25 < get_liked then 
      #   puts '創造性評価：５'
      # end

      # @post.ablution = "テスト文章が入っています #{get_liked}"
      # -----------------------------------------------------------------------------------------

      # 直近のツイートのネガティブ度を測定 ------------------------------------------------
      serch_tweet = 5
      @tweet_aggregation = ''
      twitter_client.user_timeline(user_id: current_user.twitter_id, count: serch_tweet).each do |tweet|
        @tweet_aggregation <<  tweet.full_text.encode('SJIS', 'UTF-8', invalid: :replace, undef: :replace, replace: '').encode('UTF-8').gsub(/[0-9A-Za-z]/, '')
      end
      @post.ablution = @tweet_aggregation 
      @post.tweet_diagnose
      nagative = @post.score

      if 50 < nagative then 
        puts '情動性評価：１'
      elsif (25..49) === nagative then 
        puts '情動性評価：２'
      elsif (0..24) === nagative then 
        puts '情動性評価：３'
      elsif (-24..-1) === nagative then 
        puts '情動性評価：４'
      elsif -25 > nagative then 
        puts '情動性評価：５'
      end

      # @post.ablution = "ツイートのネガポジ度：#{nagative}"

      # ------------------------------------------------------------------------------ 


      # 直近の5ツイートの投稿時間からツイートの頻度を計測--------------------
      # tweet_frequency = Array.new
      # tweet_variance = Array.new

      # # # 直近のツイートの投稿時間を配列へ
      # twitter_client.user_timeline(user_id: current_user.twitter_id, count: 5).each do |tweet|
      #   tweet_frequency <<  tweet.created_at
      # end

      # # 各ツイートの投稿の間隔を配列へ
      # for i in 1..tweet_frequency.length-1
      #   tweet_variance << tweet_frequency[i] - tweet_frequency[i-1]
      # end

      # # 投稿時間の標準偏差を出す
      # variance = stdev(tweet_variance).round
      # # これまで単位が秒数だったので日数に変換　おおよそ何日ごとに１ツイートしているか出す
      # variance = variance/3600/24

      # if 22 < variance then 
      #   puts '勤勉性評価：１'
      # elsif (14..21) === variance then 
      #   puts '勤勉性評価：２'
      # elsif (7..13) === variance then 
      #   puts '勤勉性評価：３'
      # elsif (3..6) === variance then 
      #   puts '勤勉性評価：４'
      # elsif 2 > variance then 
      #   puts '勤勉性評価：５'
      # end
      
      # @post.ablution = "ツイートの頻度は#{variance}"

      # --------------------------------------------------------------



      # その人がしているいいね数を取得　最大1000件? ------------------------------------------------

      # favorites = twitter_client.favorites(count: 1000).count
      # since = twitter_client.user(current_user.twitter_id.to_i).created_at
      # now = Time.now

      # period = (now - since).divmod(86400).each_slice(2).map { |day, sec_r| (Time.parse("1/1") + sec_r).strftime("#{day}") }.first.to_i
      # cooperation = (favorites/period.to_f).round(3) unless favorites.to_i > 1000 

      # if 0.5 > cooperation then 
      #   puts '協調性評価：１'
      #   cooperation = 1
      # elsif (0.5..1) === cooperation then 
      #   puts '協調性評価：２'
      #   cooperation = 2
      # elsif (1.1..) === cooperation then 
      #   puts '協調性評価：３'
      #   cooperation = 3
      # elsif (2.1..2.9) === cooperation then 
      #   puts '協調性評価：４'
      #   cooperation = 4
      # elsif 3 < cooperation then 
      #   puts '協調性評価：５'
      #   cooperation = 5
      # end

      # @post.ablution = "過去にどのくらいいいねをしたのか #{cooperation}"
      # ------------------------------------------------------------------------------------

      # その人がフォローしている人の数 -----------------------------------------------------------
      # followers = twitter_client.followers(count: 1).count.to_s
      # ------------------------------------------------------------------------------------


      # 今までの総ツイート数 -----------------------------------------------------------
      # ツイッターをやっている年数とかも考慮した方がいいか悩み中
      # tweet_total = twitter_client.user(current_user.twitter_id.to_i).tweets_count
      # since = twitter_client.user(current_user.twitter_id.to_i).created_at
      # now = Time.now
      # period = (now - since).divmod(86400).each_slice(2).map { |day, sec_r| (Time.parse("1/1") + sec_r).strftime("#{day}") }.first.to_i

      # extraversion =(tweet_total/period.to_f).round(3) 

      # if 0 === extraversion then 
      #   puts '外向性評価：１'
      #   extraversion = 1
      # elsif (0..0.5) === extraversion then 
      #   puts '外向性評価：２'
      #   extraversion = 2
      # elsif (0.6..1) === extraversion then 
      #   puts '外向性評価：３'
      #   extraversion = 3
      # elsif (1.1..2) === extraversion then 
      #   puts '外向性評価：４'
      #   extraversion = 4
      # elsif 2 < extraversion then 
      #   puts '外向性評価：５'
      #   extraversion = 5
      # end
 
      # @post.ablution = "外向性は#{extraversion}" 
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
    end
  end

end
