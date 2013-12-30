class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    begin
      @article = Article.find(params[:id])
      user = @article.user
      user ? @author_email = user.email : @author_email = 'unknown'
    rescue ActiveRecord::RecordNotFound => e
      flash[:notice] = 'No such article'
      redirect_to root_path
    end
  end

  
end