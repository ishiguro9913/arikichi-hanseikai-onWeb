class UserSessionsController < ApplicationController

  def guest_login
    @guest_user = User.create(
    twitter_id: SecureRandom.alphanumeric(10),
    name: '匿名様',
    )
    auto_login(@guest_user)
    redirect_to new_post_path, success: 'ゲストとしてログインしました'
  end

  def twitter_login
    @guest_user = User.create(
    twitter_id: SecureRandom.alphanumeric(10),
    name: '匿名様',
    )
    auto_login(@guest_user)
    redirect_to new_post_path, success: 'ゲストとしてログインしました'
  end

  def create
    unless request.env['omniauth.auth'][:uid]
      flash[:danger] = '連携に失敗しました'
      redirect_to root_url
    end
    user_data = request.env['omniauth.auth']
    user = User.find_by(uid: user_data[:uid])
    if user
      log_in user
      flash[:success] = 'ログインしました'
      redirect_to root_url
    else
      new_user = User.new(
        uid: user_data[:uid],
        nickname: user_data[:info][:nickname],
        name: user_data[:info][:name],
        image: user_data[:info][:image],
      )
      if new_user.save
        log_in new_user
        flash[:success] = 'ユーザー登録成功'
      else
        flash[:danger] = '予期せぬエラーが発生しました'
      end
      redirect_to root_url
    end
  end


  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
end
