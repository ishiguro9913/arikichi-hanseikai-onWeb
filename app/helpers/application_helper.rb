module ApplicationHelper
  def logged_in?
    !@current_user.nil?
  end

  # Twitterログインしていればtrue、ゲストログインならfalseを返す
  def twitter_logged_in?
    !@current_user.twitter_id.nil?
  end

end
