class BookCommentsController < ApplicationController

  def create
    @comment = current_user.book_comments.new(book_comment_params)
    @book = @comment.book
    if @comment.save
      render 'create.js.erb'
    else
      render 'comment_error.js.erb'
    end
  end

  def destroy
    @comment = current_user.book_comments.find(params[:id])
    @comment.destroy
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:book_id, :comment).merge(book_id: params[:book_id])
  end
end
