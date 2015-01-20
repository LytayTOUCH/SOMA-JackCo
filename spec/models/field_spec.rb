require 'spec_helper'

describe Field, 'validation' do
  it { should ensure_length_of(:name).is_at_most(100) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:dimension) }
  it { should validate_presence_of(:dimension) }
  it { should validate_presence_of(:lat_long) }
end

describe Field, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 100 }, presence: true) }
  it { should have_db_column(:address).of_type(:string) }
  it { should have_db_column(:note).of_type(:text) }
  it { should have_db_column(:lat_long).of_type(:text).with_options(presence: true) }
end
