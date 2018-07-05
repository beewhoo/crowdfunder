require_relative '../test_helper'

class ProjectTest < ActiveSupport::TestCase


  def test_valid_project_can_be_created
    project = create(:project, user: create(:user))
    assert project.valid?
    assert project.persisted?
  end

  def test_project_is_invalid_without_owner
    assert build(:project, user: nil).invalid?, 'Project should not save without owner.'
  end

  def test_project_start_date_in_the_future_date_in_the_past
    refute false, build(:project, start_date: Date.yesterday).in_the_future
  end

  def test_project_start_date_in_the_future
    assert true, build(:project, start_date: Date.tomorrow).in_the_future
  end

  def test_project_end_date_after_start_date
    refute false, build(:project, start_date: Date.yesterday, end_date: 12.days.ago).end_date_after_start_date
  end

  def test_project_goal_number_is_positive
    assert true, build(:project, goal: 1).goal_positive_number
  end

  def test_project_goal_number_is_zero
    refute false, build(:project, goal: 0).goal_positive_number
  end
end
