require 'spec_helper'

describe LaborSubordinate, 'column_specification' do
  it { should have_db_column(:labor_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:subordinate_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
end

describe LaborSubordinate, 'association' do
  it { should belong_to(:labor) }
  it { should belong_to(:labor).with_foreign_key('subordinate_uuid') }
end