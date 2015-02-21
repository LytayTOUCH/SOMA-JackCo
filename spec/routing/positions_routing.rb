require 'spec_helper'

describe 'routing to positions' do
  it "routes /positions/1 to positions#show" do
    expect(get: "/positions/1").to route_to(controller: "positions", action: "show", id: "1")
  end
  
  it "routes /positions/new to positions#new" do
    expect(get: "/positions/new").to route_to(controller: "positions", action: "new")
  end

  it "routes /positions to positions#create" do
    expect(post: "/positions").to route_to(controller: "positions", action: "create")
  end

  it "routes /positions/1/edit to positions#edit" do
    expect(get: "/positions/1/edit").to route_to(controller: "positions", action: "edit", id: "1")
  end

  it "routes /positions/1 to positions#update" do
    expect(put: "/positions/1").to route_to(controller: "positions", action: "update", id: "1")
  end
end