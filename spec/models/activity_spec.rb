require 'spec_helper'

describe Activity, 'validation' do
  it { should validate_presence_of(:starts_at) }
  it { should ensure_length_of(:activity_type_uuid).is_at_most(36) }
  it { should validate_presence_of(:activity_type_uuid) }
end

describe Activity, 'column_specification' do
  it { should have_db_column(:uuid).of_type(:string).with_options(length: { maximum: 36 }, presence: true) }
  it { should have_db_column(:starts_at).of_type(:datetime), presence: true }
  it { should have_db_column(:note).of_type(:text) }
end
