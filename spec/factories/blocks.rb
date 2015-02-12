# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :block do
    name "MyString"
    surface 1
    shape_lat_long "MyText"
    location_lat_long "MyString"
    tree_amount 1
    farm_id "MyString"
    planting_project_id 1
    rental_status 1
    status 1
  end
end
