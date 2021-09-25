class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ASSOCIATIONS
  # -----------------

  has_many :posts, dependent: :destroy

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
end
