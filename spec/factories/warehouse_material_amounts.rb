# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :warehouse_material_amount do
    warehouse_id "MyString"
    material_id "MyString"
    amount 1.5
  end
end
