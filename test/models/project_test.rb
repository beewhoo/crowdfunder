require_relative '../test_helper'

class ProjectTest < ActiveSupport::TestCase

  def test_valid_project_can_be_created
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  def test_project_is_invalid_without_owner
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today + 1.day,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  def test_project_start_date_in_the_future_date_in_the_past
    @project = new_project
    @project.start_date = Date.yesterday
    result = @project.in_the_future

    assert_equal false, result
  end

  def test_project_start_date_in_the_future
    project = new_project
    project.start_date = Date.tomorrow
    result = project.in_the_future

    assert_equal true, result
  end

  def test_project_end_date_after_start_date
    project = new_project
    project.start_date = Date.yesterday
    project.end_date = 12.days.ago
    result = project.end_date_after_start_date

    assert_equal false, result
  end

  def test_project_goal_number_is_positive
    project = new_project
    project.goal = 1

    result = project.goal_positive_number

    assert_equal true, result
  end

  def test_project_goal_number_is_zero
    project = new_project
    project.goal = 0

    result = project.goal_positive_number

    assert_equal false, result
  end
end
