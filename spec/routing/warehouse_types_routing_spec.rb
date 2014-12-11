require 'spec_helper'

describe 'routing to warehouse_types' do
  it "routes /warehouse_types/1 to warehouse_types#show" do
    expect(get: "/warehouse_types/1").to route_to(controller: "warehouse_types", action: "show", id: "1")
  end
  
  it "routes /warehouse_types/new to warehouse_types#new" do
    expect(get: "/warehouse_types/new").to route_to(controller: "warehouse_types", action: "new")
  end

  it "routes /warehouse_types to warehouse_types#create" do
    expect(post: "/warehouse_types").to route_to(controller: "warehouse_types", action: "create")
  end

  it "routes /warehouse_types/1/edit to warehouse_types#edit" do
    expect(get: "/warehouse_types/1/edit").to route_to(controller: "warehouse_types", action: "edit", id: "1")
  end

  it "routes /warehouse_types/1 to warehouse_types#update" do
    expect(put: "/warehouse_types/1").to route_to(controller: "warehouse_types", action: "update", id: "1")
  end
end