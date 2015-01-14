# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    starts_at "2014-12-22 10:18:14"
    ends_at "2014-12-22 10:18:14"
    all_day false
    description "MyText"
  end
end
