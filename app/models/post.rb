class Post < ApplicationRecord
  # ASSOCIATIONS
  # ------------------

  belongs_to :user

  # VALIDATIONS
  # ------------------

  validates :body, presence: true
  validates :title, presence: true
end
