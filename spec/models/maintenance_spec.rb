require 'spec_helper'

describe Maintenance, 'validation' do
  it { should ensure_length_of(:machinery_uuid).is_at_most(36) }
  it { should validate_presence_of(:machinery_uuid) }
  it { should ensure_length_of(:labor_uuid).is_at_most(36) }
  it { should validate_numericality_of(:engine_hours) }
  it { should validate_numericality_of(:time_spent) }
end

describe Maintenance, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:machinery_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:labor_uuid).of_type(:string).with_options(length: { maximum: 36 }) }
  it { should have_db_column(:engine_hours).of_type(:integer) }
  it { should have_db_column(:time_spent).of_type(:integer) }
  it { should have_db_column(:note).of_type(:text) }
end