class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)

    # その人がしているいいね数　最大1000件
    favorites = twitter_client.favorites(count: 1).count.to_s
    # その人がフォローしている人の数
    followers = twitter_client.followers(count: 1).count.to_s
  end

  private

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

end
