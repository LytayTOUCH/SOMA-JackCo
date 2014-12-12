require 'spec_helper'

describe Project, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:name) }
end

describe Project, 'column_specification' do
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
end

describe Project, 'association' do
  it { should have_many(:labors).through(:labor_projects) }
end