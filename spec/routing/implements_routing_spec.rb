require 'spec_helper'

describe 'routing to implements' do
  it "routes /implements/1 to implements#show" do
    expect(get: "/implements/1").to route_to(controller: "implements", action: "show", id: "1")
  end
  
  it "routes /implements/new to tractors#new" do
    expect(get: "/implements/new").to route_to(controller: "implements", action: "new")
  end

  it "routes /implements to implements#create" do
    expect(post: "/implements").to route_to(controller: "implements", action: "create")
  end

  it "routes /implements/1/edit to implements#edit" do
    expect(get: "/implements/1/edit").to route_to(controller: "implements", action: "edit", id: "1")
  end

  it "routes /implements/1 to tractors#update" do
    expect(put: "/implements/1").to route_to(controller: "implements", action: "update", id: "1")
  end
end
