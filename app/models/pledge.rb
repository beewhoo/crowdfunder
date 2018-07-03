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
end
