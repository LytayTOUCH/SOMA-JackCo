require 'spec_helper'

describe Tractor, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:horse_power) }
  it { should validate_numericality_of(:fuel_capacity) }
  it { should validate_numericality_of(:value) }
end

describe Tractor, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
  it { should have_db_column(:horse_power).of_type(:float).with_options(numericality: true) }
  it { should have_db_column(:fuel_capacity).of_type(:float).with_options(numericality: true) }
  it { should have_db_column(:make).of_type(:string) }
  it { should have_db_column(:model).of_type(:string) }
  it { should have_db_column(:year).of_type(:date) }
  it { should have_db_column(:value).of_type(:float).with_options(numericality: true) }
  it { should have_db_column(:note).of_type(:text) }
end
