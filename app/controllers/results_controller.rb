class ResultsController < ApplicationController
  before_action :require_login

  def new
    @post = Post.find_by(id: params[:format])
  end

  def not_authenticated
    redirect_to login_url, alert: 'ログインしてください'
  end

end
