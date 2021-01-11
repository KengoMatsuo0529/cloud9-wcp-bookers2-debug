class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :follower, source: :followed
  has_many :followers, through: :followed, source: :follower

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def follow(other_user)
    self.follower.find_or_create_by(followed_id: other_user) #relatioonshipもでるにさくせいするめそっど
  end

  def unfollow(other_user)
    self.follower.find_by(followed_id: other_user).destroy
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  
  def self.search(search,word)
      if search == "forward_search"
        @user = User.where("name LIKE?," "#{word}%")
      elsif search == "backward_search"
        @user = User.where("name LIKE?", "%#{word}")
      elsif search == "perfect_match"
        @user = User.where("#{word}")
      elsif search == "partial_match"
        @user = User.where("name LIKE?", "%#{word}%")
      else
        @user = User.all
      end
  end
  
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
end
