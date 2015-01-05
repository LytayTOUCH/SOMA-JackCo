require 'spec_helper'

describe ActivityType, 'validation' do
  it { should ensure_length_of(:name).is_at_most(50) }
end

describe ActivityType, 'column-specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }) }
  it { should have_db_column(:note).of_type(:text) }
end
