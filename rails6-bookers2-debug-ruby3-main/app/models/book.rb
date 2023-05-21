class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  # 渡された期間内のfavoritesが多い順に降順にする。
  # 第2キーにtitle昇順
  def self.sort_by_favorites_count_desc(from, to)
    Book.left_joins(:favorites)
        .select('books.*, COUNT(favorites.id) AS favorites_count')
        .group('books.id')
        .order('favorites_count DESC, books.title ASC')
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
