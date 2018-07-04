class User < ActiveRecord::Base
  has_secure_password
  has_many :pledges
  has_many :owned_projects, class_name: "Project", foreign_key: :user_id
  has_many :backed_projects, through: :pledges, source: :project

  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def amount_pledged
    pledges.sum(:dollar_amount)
    # colon specifies which column to look at when doing the sum for the user's pledges
  end
end
