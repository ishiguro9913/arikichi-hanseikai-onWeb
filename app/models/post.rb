class Post < ApplicationRecord

  validates :content, presence: true  
  belongs_to :user

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
end
