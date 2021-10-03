class Follow < ApplicationRecord
  # ASSOCIATIONS
  # --------------------

  belongs_to :user
  belongs_to :recipient, class_name: 'User'

  # VALIDATIONS
  # --------------------

  validates :user, uniqueness: { scope: :recipient, message: 'can\'t be followed twice' }
end
