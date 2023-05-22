class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.new(book_id: @book.id)
    if favorite.save
      render_js_by_request
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: @book.id)
    if favorite.destroy
      render_js_by_request
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def render_js_by_request
    render 'renderFavorite.js.erb' if request.referer.blank?

    case URI(request.referer.to_s).path
      when %r(^\/users)
        @books = current_user.books
        return render 'renderBooks.js.erb'
      when %r(^\/books$)
        to = Time.zone.now.at_end_of_day
        from = (to - 6.days).at_beginning_of_day
        @books = Book.sort_by_favorites_count_desc(from, to)
        return render 'renderBooks.js.erb'
      when %r(^\/books\/\d)
        return render 'renderFavorite.js.erb'
    end
  end
end