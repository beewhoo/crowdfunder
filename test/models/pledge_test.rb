require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  def test_a_pledge_can_be_created
    pledge = Pledge.create(
      dollar_amount: 99.00,
      project: new_project,
      user: new_user
    )
    pledge.save
    assert pledge.valid?
    assert pledge.persisted?
  end

  def test_owner_cannot_back_own_project
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    pledge = Pledge.new(dollar_amount: 3.00, project: project)
    pledge.user = owner
    pledge.save
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
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

  def test_a_pledge_cannot_be_created_without_a_positive_dollar_amount
    @project = new_project
    @pledge = @project.pledges.build
    @pledge.dollar_amount = 1
    #act
    result = @pledge.greater_than_zero(@pledge.dollar_amount)
    #assert
    assert_equal true, result
  end

  def test_a_pledge_cannot_be_created_with_a_negative_number
    @project = new_project
    @pledge = @project.pledges.build
    @pledge.dollar_amount = -1
    #act
    result = @pledge.greater_than_zero(@pledge.dollar_amount)
    #assert
    assert_equal false, result
  end

  def test_a_pledge_cannot_be_created_with_zero
    @project = new_project
    @pledge = @project.pledges.build
    @pledge.dollar_amount = 0
    #act
    result = @pledge.greater_than_zero(@pledge.dollar_amount)
    #assert
    assert_equal false, result
  end
end
