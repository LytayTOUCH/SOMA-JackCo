require 'spec_helper'

describe 'routing to dashboards' do
  it "routes /dashboards to dashboards#index" do
    expect(get: "/dashboards").to route_to(controller: "dashboards", action: "index")
  end
end