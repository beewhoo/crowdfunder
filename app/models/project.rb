class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true


  def in_the_future
    if self.start_date > DateTime.now
      true
    else
      errors.add(:user, "Start date must be in the future.")
      false
    end
  end

  def end_date_after_start_date
    if self.end_date > self.start_date
      true
    else
      errors.add(:user, "End date must be after Start date")
      false
    end
  end

  def goal_positive_number
    if self.goal > 0
      true
    else
      errors.add(:user, 'Project goal must be a postive amount')
      false
    end
  end
end
