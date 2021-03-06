class User < ActiveRecord::Base
  has_secure_password

  has_many :projects
  has_many :pledges


  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true


  def projects_pledged
    pledges.map { |pledge| pledge.project }.uniq
  end

  def total_pledged
    pledges.sum(:dollar_amount)
  end


end
