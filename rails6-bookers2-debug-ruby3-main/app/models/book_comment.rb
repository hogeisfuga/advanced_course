class BookComment < ApplicationRecord
  validates :comment, presence: true

  belongs_to :book, dependent: :destroy
  belongs_to :user

end
