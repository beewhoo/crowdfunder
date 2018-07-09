class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  belongs_to :category

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validates :goal, presence:true, numericality: { greater_than: 0 }
  validate :start_date_future
  validate :end_date_greater_start_date





  def start_date_future
     if  start_date && start_date < Date.today
       errors.add(:start_date, "must be in future")
     end
   end


   def end_date_greater_start_date
     if  start_date &&  end_date && end_date <= start_date
       errors.add(:end_date, "end date must be greater than start date")
     end
   end


  def pledge_sum
    self.pledges.sum(:dollar_amount)
  end


  def current_user_pledges(current_user)
    if current_user
   pledges.all.where('user_id = ?', current_user.id).all
   else
     []
   end
 end

 def user_pledged?(current_user)
    current_user_pledges(current_user).count > 0
end



 def current_user_pledged_sum(current_user)
   current_user_pledges(current_user).sum(:dollar_amount)
 end



end
