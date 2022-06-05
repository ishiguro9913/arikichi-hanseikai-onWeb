class ResultsController < ApplicationController
  before_action :require_login
  after_action :save_post
  before_action :set_user, only: %i[ new show edit update destroy ]

  def new
    @post = Post.find_by(id: params[:format])
  end

  def not_authenticated
    redirect_to login_url, alert: 'ログインしてください'
  end

  def save_post
    @post.save!
  end

  def set_user
    @user = current_user
  end

end
