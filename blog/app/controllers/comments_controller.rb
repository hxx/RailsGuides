class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to articles_path(@article)
  end

  def destory
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  def index
    @comments = Comment.find_no_spam
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
