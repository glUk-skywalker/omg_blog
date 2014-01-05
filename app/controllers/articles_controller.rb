class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    if params.has_key?(:tag)
      @articles = Article.find_by_sql("SELECT * FROM articles WHERE tags LIKE '%#{params[:tag]}%'")
      @tag = params[:tag]
    elsif params.has_key?(:author)
      @articles = Article.where(user_id: User.find_by(email: params[:author]))
      @author = params[:author]
    else
      @articles = Article.all
    end
  end

  def show
    begin
      @article = Article.find(params[:id])
      @comment = Comment.new
    rescue ActiveRecord::RecordNotFound => e
      flash[:notice] = 'No such article'
      redirect_to root_path
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(user_id: current_user.id, title: params[:article][:title], text: params[:article][:text], tags: params[:article][:tags])
    if @article.save
      redirect_to @article
    else
      flash.now[:notice] = @article.errors.full_messages.to_s
      render 'new'
    end
  end
end