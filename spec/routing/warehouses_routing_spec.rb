require 'spec_helper'

describe 'routing to warehouses' do
  it "routes /warehouses/1 to warehouses#show" do
    expect(get: "/warehouses/1").to route_to(controller: "warehouses", action: "show", id: "1")
  end
  
  it "routes /warehouses/new to warehouses#new" do
    expect(get: "/warehouses/new").to route_to(controller: "warehouses", action: "new")
  end

  it "routes /warehouses to warehouses#create" do
    expect(post: "/warehouses").to route_to(controller: "warehouses", action: "create")
  end

  it "routes /warehouses/1/edit to warehouses#edit" do
    expect(get: "/warehouses/1/edit").to route_to(controller: "warehouses", action: "edit", id: "1")
  end

  it "routes /warehouses/1 to warehouses#update" do
    expect(put: "/warehouses/1").to route_to(controller: "warehouses", action: "update", id: "1")
  end
end