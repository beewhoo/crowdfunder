# require 'test_helper'
require_relative '../test_helper'

class ProjectTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def test_valid_project_can_be_created
    project = create(:project)
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  def test_project_is_invalid_without_owner
    project = build(:project, user: nil)
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  def test_pledge_sum
    project = create(:project)

    create(:pledge, project: project, dollar_amount: 10)
    create(:pledge, project: project, dollar_amount: 20)
    create(:pledge, project: project, dollar_amount: 30)


    assert_equal(60, project.pledge_sum)

  end

  def test_current_user_pledged_sum
    project = create(:project)
    user = create(:user)
    pledge1 = create(:pledge, user: user, project: project)
    pledge2 = create(:pledge, user: user, project: project)

    assert_equal(10, project.current_user_pledged_sum(user))

  end


  def test_current_user_pledges_returns_all_users_pledges
    project = create(:project)
    user = create(:user)
    array = []
    pledge1 = create(:pledge, user: user, project: project)
    pledge2 = create(:pledge, user: user, project: project)
    array << pledge1
    array << pledge2

    assert_equal(array, project.current_user_pledges(user))

  end

  def test_current_user_pledges_returns_empty_array
    project = create(:project)
    user = create(:user)
    empty_array = []

    assert_equal(empty_array, project.current_user_pledges(user))
  end


  def test_project_start_date_in_the_future?
    project = build(:project, start_date: Date.yesterday)
    assert project.invalid?
  end

   def test_end_date_greater_start_date
     project = build(:project, start_date: Date.today, end_date: Date.today)
     assert project.invalid?
   end

   def test_goal_must_be_negative
     project = build(:project, goal: -1)
     assert project.invalid?
   end
   def test_goal_must_be_zero
     project = build(:project, goal: 0)
     assert project.invalid?
   end
   def test_goal_must_be_positve
     project = build(:project, goal: 1)
     assert project.valid?
   end


   def test_uniq
     array = []

  project = create(:project)
    3.times do
      array << project
    end
   assert array.uniq

    end




end
