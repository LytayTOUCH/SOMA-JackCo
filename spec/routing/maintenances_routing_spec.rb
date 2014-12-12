require 'spec_helper'

describe 'routing to maintenances' do
  it "routes /maintenances/1 to maintenances#show" do
    expect(get: "/maintenances/1").to route_to(controller: "maintenances", action: "show", id: "1")
  end
  
  it "routes /maintenances/new to tractors#new" do
    expect(get: "/maintenances/new").to route_to(controller: "maintenances", action: "new")
  end

  it "routes /maintenances to maintenances#create" do
    expect(post: "/maintenances").to route_to(controller: "maintenances", action: "create")
  end

  it "routes /maintenances/1/edit to maintenances#edit" do
    expect(get: "/maintenances/1/edit").to route_to(controller: "maintenances", action: "edit", id: "1")
  end

  it "routes /maintenances/1 to tractors#update" do
    expect(put: "/maintenances/1").to route_to(controller: "maintenances", action: "update", id: "1")
  end
end
