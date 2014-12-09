require 'spec_helper'

describe 'routing to machineries' do
  it "routes /machineries to machineries#index" do
    expect(get: "/machineries").to route_to(controller: "machineries", action: "index")
  end
end