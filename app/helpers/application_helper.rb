module ApplicationHelper
  def logged_in?
    !@current_user.nil?
  end

  # # Twitterログインしていればtrue、ゲストログインならfalseを返す
  # def twitter_logged_in?
  #   binding.pry
  #   !@current_user.nil? && !@current_user.twitter_id.nil?
  # end

  # def guest_logged_in?
  #   !@current_user.nil? && !@current_user.id == 1
  # end

end
