require 'spec_helper'

describe LaborProject, 'validation' do
  it { should ensure_length_of(:labor_uuid).is_at_most(36) }
  it { should validate_presence_of(:labor_uuid) }
  it { should ensure_length_of(:project_uuid).is_at_most(36) }
  it { should validate_presence_of(:project_uuid) }
end

describe LaborProject, 'column_specification' do
  it { should have_db_column(:labor_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:project_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
end
