class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true


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
