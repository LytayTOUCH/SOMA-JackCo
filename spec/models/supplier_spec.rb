require 'spec_helper'

describe Supplier, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:contact_person).is_at_most(100) }
  it { should ensure_length_of(:phone).is_at_most(20) }
  it { should ensure_length_of(:email).is_at_most(100) }
end

describe Supplier, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }, presence: true) }
  it { should have_db_column(:contact_person).of_type(:string).with_options(length: { maximum: 100 }) }
  it { should have_db_column(:phone).of_type(:string).with_options(length: { maximum: 20 }) }
  it { should have_db_column(:email).of_type(:string).with_options(length: { maximum: 100 }) }
  it { should have_db_column(:address).of_type(:text) }
  it { should have_db_column(:active).of_type(:boolean).with_options(default: true) }
end
