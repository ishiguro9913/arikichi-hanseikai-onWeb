class OauthsController < ApplicationController
  # skip_before_action :require_login # applications_controllerでbefore_action :require_loginを設定している場合

  skip_before_action :require_login, raise: false
      
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    # login_at(params[:provider])
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if auth_params[:denied].present?
      redirect_to root_path, notice: "ログインをキャンセルしました"
      return
    end
    # 送られてきた認証情報でログインできなかったとき（該当するユーザーがいない場合）、新規ユーザーを作成する
    # create_user_from(provider) unless (@user = login_from(provider))
    # redirect_to new_post_path, success: "#{provider.titleize}でログインしました" 
    if (@user = login_from(provider)) 
      redirect_to new_post_path, success: "#{provider.titleize}でログインしました"
    else
      create_user_from(provider)
      redirect_to new_post_path, success: "#{provider.titleize}で新規登録しました"
    end
  end

    private

    def auth_params
      params.permit(:code, :provider, :denied)
    end

    # def create_user_from(provider)
    #   @user = build_from(provider) # ①
    #   @user.authentications.build(uid: @user_hash[:uid],
    #                              provider: provider,
    #                              access_token: access_token.token,
    #                              access_token_secret: access_token.secret) # ②
    #   @user.save! # ③ 
    #   reset_session
    #   auto_login(@user)
    # end

    def create_user_from(provider)
      @user = create_from(provider)
      reset_session
      auto_login(@user)
    end
  end
