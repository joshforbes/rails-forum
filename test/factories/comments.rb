FactoryGirl.define do
  factory :comment do
    user
    post
    body Faker::Lorem.paragraph(2)
  end
end
