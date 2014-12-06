require 'spec_helper'

describe Material, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:quantity) }
  it { should ensure_length_of(:unit).is_at_most(100) }
  it { should validate_presence_of(:unit) }
end

describe Material, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
  it { should have_db_column(:quantity).of_type(:float) }
  it { should have_db_column(:unit).of_type(:string).with_options(length: { maximum: 100 }) }
  it { should have_db_column(:supplier_uuid).of_type(:string).with_options(length: { maximum: 36 }) }
  it { should have_db_column(:warehouse_uuid).of_type(:string).with_options(length: { maximum: 36 }) }
end

describe Material, 'association' do
  it { should belong_to(:supplier).with_foreign_key('supplier_uuid') }
end