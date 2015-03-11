require 'spec_helper'

describe Production, 'validation' do
  it { should ensure_length_of(:status).is_at_most(20) }
  it { should validate_presence_of(:status) }
  it { should ensure_length_of(:planting_project_id).is_at_most(36) }
  it { should validate_presence_of(:planting_project_id) }
  it { should ensure_length_of(:uom_id).is_at_most(36) }
  it { should validate_presence_of(:uom_id) }
end

describe Production, 'column-specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:status).of_type(:string).with_options(length: { maximum: 20 }, presence: true) }
  it { should have_db_column(:planting_project_id).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:uom_id).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:note).of_type(:text) }
end  

describe Production, 'association' do
  it { should belong_to(:planting_project).with_foreign_key('planting_project_id') }
  it { should belong_to(:unit_of_measurement).with_foreign_key('uom_id') }
end
