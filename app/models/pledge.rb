class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :check_owner


  def check_owner
    if project.user == user
      errors.add(:user, "Can't pledge to your own project!")
    end
  end

  def greater_than_zero(num)
    if num > 0
      true
    else
      errors.add(:user, "Pledge must be a value greater than 0!")
      false
    end
  end

end
