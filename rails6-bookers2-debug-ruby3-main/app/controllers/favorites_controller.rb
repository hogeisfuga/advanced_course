class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
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
    request.path.match?(/users/) ? users_path(current_user) : books_path
  end

end
