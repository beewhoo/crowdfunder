require '../test_helper'

class RewardTest < ActiveSupport::TestCase

  def test_a_reward_can_be_created
    reward = create(:reward)
    assert reward.valid?
    assert reward.persisted?
  end

  def test_a_reward_cannot_be_created_without_a_dollar_amount
    reward = build(:reward, dollar_amount:nil)
    reward.save

    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  def test_a_reward_cannot_be_created_without_a_description
    reward = build(:reward, description:nil)
    reward.save

    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end



end
