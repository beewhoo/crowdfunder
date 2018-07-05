require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  def test_a_pledge_can_be_created
   pledge = create(:pledge)
   assert pledge.valid?
   assert pledge.persisted?
  end

  def test_owner_cannot_back_own_project
    owner = create(:user)
    project = create(:project)
    pledge = create(:pledge, user: owner, project: project, dollar_amount: 10.00)
    pledge.project.user = owner
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end
end 
