require 'spec_helper'

describe LaborSubordinate do
  it { should ensure_length_of(:labor_uuid).is_at_most(36) }
  it { should validate_presence_of(:labor_uuid) }
  it { should ensure_length_of(:subordinate_uuid).is_at_most(36) }
  it { should validate_presence_of(:subordinate_uuid) }
end

describe LaborSubordinate, 'column_specification' do
  it { should have_db_column(:labor_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:subordinate_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
end
