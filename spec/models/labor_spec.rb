require 'spec_helper'

describe Labor, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:name) }

  it { should ensure_length_of(:position_uuid).is_at_most(36) }
  it { should validate_presence_of(:position_uuid) }
end

describe Labor, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
  it { should have_db_column(:position_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:description).of_type(:text) }
end

describe Labor, 'association' do
  it { should have_many(:labor_projects).with_foreign_key('labor_uuid').dependent(:destroy) }
  it { should have_many(:projects).through(:labor_projects) }
end
