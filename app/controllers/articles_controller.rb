class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

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

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(user_id: current_user.id, title: params[:article][:title], text: params[:article][:text])
    if @article.save
      redirect_to @article
    else
      flash.now[:notice] = @article.errors.full_messages.to_s
      render 'new'
    end
  end
end