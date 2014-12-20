require 'spec_helper'

describe Activity, 'validation' do
  it { should ensure_length_of(:name).is_at_most(100) }
  it { should validate_presence_of(:name) }
end
