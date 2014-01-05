class CommentsController < ApplicationController
  def create
    user_id = nil
    user_id = current_user.id if current_user
    @comment = Comment.new(user_id: user_id, article_id: params[:comment][:article_id], text: params[:comment][:text])
    @comment.save
    redirect_to Article.find(params[:comment][:article_id])
  end
end