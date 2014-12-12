require 'spec_helper'

describe LaborProject, 'column_specification' do
  it { should have_db_column(:labor_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:project_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
end

describe LaborProject, 'association' do
  it { should belong_to(:labor).with_foreign_key('labor_uuid') }
  it { should belong_to(:project).with_foreign_key('project_uuid') }
end