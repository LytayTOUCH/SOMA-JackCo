require 'spec_helper'

describe Labor, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:position_uuid).is_at_most(36) }
  it { should validate_presence_of(:position_uuid) }
  it { should ensure_length_of(:labor_project_uuid).is_at_most(36) }
  it { should ensure_length_of(:labor_subordinate).is_at_most(36) }
end

describe Labor, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
  it { should have_db_column(:position_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:labor_project_uuid).of_type(:string).with_options(length: { maximum: 36 }) }
  it { should have_db_column(:labor_subordinate).of_type(:string).with_options(length: { maximum: 36 }) }
  it { should have_db_column(:description).of_type(:text) }
end