FactoryGirl.define do
  factory :state, parent: :state_faker do
  end

  factory :state_faker do
    name { Faker::Team.name.titleize }
  end
end
