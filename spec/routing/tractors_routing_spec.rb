require 'spec_helper'

describe 'routing to tractors' do
  it "routes /tractors/1 to tractors#show" do
    expect(get: "/tractors/1").to route_to(controller: "tractors", action: "show", id: "1")
  end
  
  it "routes /tractors/new to tractors#new" do
    expect(get: "/tractors/new").to route_to(controller: "tractors", action: "new")
  end

  it "routes /tractors to tractors#create" do
    expect(post: "/tractors").to route_to(controller: "tractors", action: "create")
  end

  it "routes /tractors/1/edit to tractors#edit" do
    expect(get: "/tractors/1/edit").to route_to(controller: "tractors", action: "edit", id: "1")
  end

  it "routes /tractors/1 to tractors#update" do
    expect(put: "/tractors/1").to route_to(controller: "tractors", action: "update", id: "1")
  end
end