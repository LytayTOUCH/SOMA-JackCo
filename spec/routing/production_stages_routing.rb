require 'spec_helper'

describe 'routing to production_stages' do
  it "routes /production_stages/1 to production_stages#show" do
    expect(get: "/production_stages/1").to route_to(controller: "production_stages", action: "show", id: "1")
  end
  
  it "routes /production_stages/new to production_stages#new" do
    expect(get: "/production_stages/new").to route_to(controller: "production_stages", action: "new")
  end

  it "routes /production_stages to production_stages#create" do
    expect(post: "/production_stages").to route_to(controller: "production_stages", action: "create")
  end

  it "routes /production_stages/1/edit to production_stages#edit" do
    expect(get: "/production_stages/1/edit").to route_to(controller: "production_stages", action: "edit", id: "1")
  end

  it "routes /production_stages/1 to production_stages#update" do
    expect(put: "/production_stages/1").to route_to(controller: "production_stages", action: "update", id: "1")
  end
end