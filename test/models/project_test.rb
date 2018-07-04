require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def test_valid_project_can_be_created
    owner = create(:user, first_name: "Sally", last_name: "Lowenthal", email: "sally@example.com", password: "passpass", password_confirmation: "passpass")
    project = create(:project, title: "cool new boardgame", description: "Trade sheep", start_date: Date.today + 1.day, end_date: Date.today + 1.month, goal: 5000, user: owner)
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  def test_project_is_invalid_without_owner
    project = build(:project, title: "cool new boardgame", description: "Trade sheep", start_date: Date.today + 1.day, end_date: Date.today + 1.month, goal: 5000)
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end



end
