FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "user#{i}" }
    password "1111"
    status 1
  end
  factory :invalid_user, class: User do
    name ""
    password "1111"
    status 1
  end
end
