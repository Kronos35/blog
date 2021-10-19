class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ASSOCIATIONS
  # -----------------

  has_many :posts, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followings, class_name: 'Follow', foreign_key: 'recipient_id', dependent: :destroy, inverse_of: :user
  has_many :followers, class_name: 'User', through: :followings, source: :user
  has_many :followed_users, class_name: 'User', through: :follows, source: :recipient

  # VALIDATIONS
  # -----------------

  validates :name, presence: true
  validates :password, length: { minimum: 8, maximum: 30 }
  validate :password_complexity

  def password_complexity
    return if password.blank?

    errors.add :password, 'must include a special character' unless password.match?(/[#?!@$%^&*-]/)
    errors.add :password, 'must include a capital character' unless password.match?(/[A-Z]/)
    errors.add :password, 'must include a lowercase character' unless password.match?(/[a-z]/)
  end

  def follow!(user)
    return if user == self

    follows.create recipient: user
  end

  def followed_posts
    Post.where(user: followed_users.to_a.push(self))
  end
end
