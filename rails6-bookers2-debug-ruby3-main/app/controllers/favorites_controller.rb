class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.new(book_id: params[:book_id])
    favorite.save
    redirect_to back_path
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: params[:book_id])
    favorite.destroy
    redirect_to back_path
  end

  private

  def back_path
    case request.path
    when %r(^\/users)
      return users_path(current_user)
    when %r(^\/books\/\d)
      return book_path(params[:book_id])
    when %r(^\/books$)
      return books_path
    else
      root_path
    end
  end

end
