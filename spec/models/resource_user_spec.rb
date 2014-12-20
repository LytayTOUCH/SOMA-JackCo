require 'spec_helper'

describe ResourceUser, 'association' do
  it { should belong_to(:resource) }
  it { should belong_to(:user) }
end