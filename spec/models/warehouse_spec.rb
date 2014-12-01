require 'spec_helper'

describe Warehouse, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:labor_uuid).is_at_most(36) }
  it { should ensure_length_of(:warehouse_type_uuid).is_at_most(36) }
end

describe Warehouse, 'column-specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
  it { should have_db_column(:labor_uuid).of_type(:string).with_options(length: { maximum: 36 }) }
  it { should have_db_column(:warehouse_type_uuid).of_type(:string).with_options(length: { maximum: 36 }) }
  it { should have_db_column(:note).of_type(:text) }
  it { should have_db_column(:active).of_type(:boolean) }
end  
