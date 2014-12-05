require 'spec_helper'

describe Implement, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:implement_type_uuid).is_at_most(36) }
  it { should validate_presence_of(:implement_type_uuid) }
  it { should ensure_length_of(:year).is_at_most(10) }
end

describe Implement, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
  it { should have_db_column(:year).of_type(:string).with_options(length: { maximum: 10 }) }
  it { should have_db_column(:implement_type_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:value).of_type(:float).with_options(numericality: true) }
  it { should have_db_column(:note).of_type(:text) }
end
