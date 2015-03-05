require 'spec_helper'

describe 'routing to warehouse_item_transactions' do
  it "routes /warehouse_item_transactions/1 to warehouse_item_transactions#show" do
    expect(get: "/warehouse_item_transactions/1").to route_to(controller: "warehouse_item_transactions", action: "show", id: "1")
  end
  
  it "routes /warehouse_item_transactions/new to warehouse_item_transactions#new" do
    expect(get: "/warehouse_item_transactions/new").to route_to(controller: "warehouse_item_transactions", action: "new")
  end

  it "routes /warehouse_item_transactions to warehouse_item_transactions#create" do
    expect(post: "/warehouse_item_transactions").to route_to(controller: "warehouse_item_transactions", action: "create")
  end

  it "routes /warehouse_item_transactions/1/edit to warehouse_item_transactions#edit" do
    expect(get: "/warehouse_item_transactions/1/edit").to route_to(controller: "warehouse_item_transactions", action: "edit", id: "1")
  end

  it "routes /warehouse_item_transactions/1 to warehouse_item_transactions#update" do
    expect(put: "/warehouse_item_transactions/1").to route_to(controller: "warehouse_item_transactions", action: "update", id: "1")
  end
end