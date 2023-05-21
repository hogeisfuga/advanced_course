class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites
  has_many :book_comments
  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy

  has_many :followings, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :messages
  has_many :message_room_users
  has_many :message_rooms, through: :message_room_users

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def follow(user)
    followings << user unless followings.include?(user)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def follow?(user)
    followings.include?(user)
  end

  def mutual_follower?(user)
    followings.include?(user) && user.followings.include?(self)
  end

  def has_message_room_with?(user)
    ids = user.message_rooms.ids
    message_rooms.ids.any? { |id| ids.include?(id) }
  end

  def room_with(user)
    room_id = user.message_rooms.ids & message_rooms.ids
    MessageRoom.find(room_id)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
