# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :input_task do
    name "MyString"
    start_date "2015-03-18"
    end_date "2015-03-18"
    block_id "MyString"
    tree_amount 1
    labor_id "MyString"
    reference_number "MyString"
    warehouse_id "MyString"
    material_id "MyString"
    material_amount ""
    note "MyString"
    created_by "MyString"
    updated_by "MyString"
  end
end
