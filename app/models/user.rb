class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :posts, dependent: :destroy

  has_many :authentications, :dependent => :destroy
  #has_one :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  # # Twitterログインしていればtrue、ゲストログインならfalseを返す
  # def twitter_logged_in?
  #   # !@current_user.twitter_id.nil?
  #   binding.pry
  #   !@user.twitter_id.nil?
  # end

  # def guest_logged_in?
  #   # !@current_user.twitter_id.nil?
  #   !@user.twitter_id.nil?
  # end 
end
