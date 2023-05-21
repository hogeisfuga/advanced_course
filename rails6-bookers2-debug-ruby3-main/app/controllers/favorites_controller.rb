class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    if favorite.save
      set_books
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    if favorite.destroy
      set_books
    end
  end

  private

  def set_books
    to = Time.zone.now.at_end_of_day
    from = (to - 6.days).at_beginning_of_day
    @books = Book.sort_by_favorites_count_desc(from, to)
  end

end
