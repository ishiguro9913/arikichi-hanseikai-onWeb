class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    # post = @post
    
    magnitude = @post.get_sentiment
    
    # content.get_sentiment
    

    @post.score = magnitude
    @post.ablution = 'テスト用の禊文章です'
    @post.name = current_user.name
    @post.save!


    
    redirect_to result_path(@post.id), success: '投稿が成功しました。'
  end

  private

  def post_params
    params.require(:post).permit(:content, :name, :score) 
  end
  
end
