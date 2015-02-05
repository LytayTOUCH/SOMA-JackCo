require 'spec_helper'

describe JackFruit, 'validation' do
  it { should ensure_length_of(:code).is_at_most(50) }
  it { should validate_presence_of(:code) }
  it { should ensure_length_of(:grown_by).is_at_most(30) }
  it { should validate_presence_of(:grown_by) }
  it { should ensure_length_of(:jack_fruit_type).is_at_most(30) }
  it { should validate_presence_of(:jack_fruit_type) }
  it { should ensure_length_of(:stage_uuid).is_at_most(36) }
  it { should validate_presence_of(:stage_uuid) }
  it { should ensure_length_of(:field_uuid).is_at_most(36) }
  it { should validate_presence_of(:field_uuid) }
end

describe JackFruit, 'column-specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:code).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
  it { should have_db_column(:grown_by).of_type(:string).with_options(length: { maximum: 30 }, presence: true) }
  it { should have_db_column(:jack_fruit_type).of_type(:string).with_options(length: { maximum: 30 }, presence: true) }
  it { should have_db_column(:planting_date).of_type(:date) }
  it { should have_db_column(:stage_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:field_uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:note).of_type(:text) }
end  
