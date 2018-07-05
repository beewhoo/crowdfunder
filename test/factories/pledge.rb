FactoryBot.define do
  factory :pledge do
    dollar_amount    5
    user
    project
  end
end
