class BookCommentsController < ApplicationController

  def create
    comment = current_user.book_comments.new(book_comment_params)
    if comment.save
      redirect_to book_path(comment.book)
    else
      @book = comment.book
      @comment = comment
      render 'books/show'
    end
  end

  def destroy
    comment = current_user.book_comments.find(params[:id])
    comment.destroy
    redirect_to book_path(params[:book_id])
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:book_id, :comment).merge(book_id: params[:book_id])
  end
end
