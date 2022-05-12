class ResultsController < ApplicationController

  def new
    @post = Post.find_by(id: params[:format])

    
  end

end
