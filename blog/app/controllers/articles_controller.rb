class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def delete
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def is_read_articles
    @is_read_articles = Article.where("is_read = ?", true).order("created_at DESC")
  end
  
  def current_article
    # This method is called several times per request, which means that the database is also called several times per request.
    # @current_article = Article.find(params[:id])

    # The important thing to note is the OR symbol. The first time the line above is called, the @current_article variable will be nil and so the database call will be made. For all subsequent calls to the same method, @current_article will contain the current user so the request to the database won’t be made. 
    @current_article ||= Article.find(params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
