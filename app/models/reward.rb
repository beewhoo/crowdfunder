class Reward < ActiveRecord::Base
  belongs_to :project
  validates :description, :dollar_amount, presence:true

  def greater_than_zero
    if self.dollar_amount > 0
      true
    else
      errors.add(:user, "Dollar amount must be a value greater than 0!")
      false
    end
  end


end
