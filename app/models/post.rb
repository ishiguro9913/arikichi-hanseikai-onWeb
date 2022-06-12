class Post < ApplicationRecord

  validates :content, presence: true  
  belongs_to :user

  enum status: { private: 0, public: 1 }, _prefix: true

  def get_sentiment
    require 'net/http'
    require 'uri'
    require 'json'
  # textに入れた文章が評価されます。
    text = self.content

  # ENV["GOOGlE_API_KYE"]に取得したAPIキーを入れます。
  
    uri = URI.parse("https://language.googleapis.com/v1beta1/documents:analyzeSentiment?key=#{ENV["GOOGlE_API_KEY"]}")
    # binding.pry
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = ""
    request.body = {
                      document:{
                        type:'PLAIN_TEXT',
                        content: text
                      }
                    }.to_json

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    json = JSON.parse(response.body)
  # scoreに文章のポジティブ度が入ります。
  
    # score =  json['documentSentiment']['score']*100
    
  # magnitudeに文章の感情の強さみたいなものが入ります。
    self.score = json['documentSentiment']['magnitude']*100
    # sentiment = {score: score.to_i, magnitude: magnitude.to_i}

    # return magnitude
  end


  def sum_i
    sum = reduce(:+)
    m = sum.to_f / size
    var = reduce(0) { |a,b| a + (b - m) ** 2 } / (size - 1)
    Math.sqrt(var)
  end

  def mean
    sum.to_f / size
  end

  def var
    m = mean
    reduce(0) { |a,b| a + (b - m) ** 2 } / (size - 1)
  end

  def sd
    Math.sqrt(var)
  end

  def tweet_diagnose
    require 'net/http'
    require 'uri'
    require 'json'
  # textに入れた文章が評価されます。
    text = self.ablution

  # ENV["GOOGlE_API_KYE"]に取得したAPIキーを入れます。
  
    uri = URI.parse("https://language.googleapis.com/v1beta1/documents:analyzeSentiment?key=#{ENV["GOOGlE_API_KEY"]}")
    # binding.pry
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = ""
    request.body = {
                      document:{
                        type:'PLAIN_TEXT',
                        content: text
                      }
                    }.to_json

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    json = JSON.parse(response.body)
  # scoreに文章のポジティブ度が入ります。
    self.score = json['documentSentiment']['score']*100
    # score =  json['documentSentiment']['score']*100
    
  # magnitudeに文章の感情の強さみたいなものが入ります。
    # self.score = json['documentSentiment']['magnitude']*100
    # sentiment = {score: score.to_i, magnitude: magnitude.to_i}

    # return magnitude
  end

  def get_ablution
    ablutions = ['お風呂で冷水をかぶりましょう',
                 '滝に打たれましょう', 
                 'ボランティアに参加しましょう',
                 '１ヶ月禁酒しましょう']
    num = rand(3)
    self.ablution = ablutions[num]
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
