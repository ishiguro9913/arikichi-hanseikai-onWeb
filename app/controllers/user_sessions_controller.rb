class UserSessionsController < ApplicationController

  def guest_login
    @guest_user = User.create(
    twitter_id: SecureRandom.alphanumeric(10),
    name: '匿名様',
    )
    auto_login(@guest_user)
    redirect_to new_post_path, success: 'ゲストとしてログインしました'
  end

end
