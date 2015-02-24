require 'spec_helper'

describe 'routing to production_statuses' do
  it "routes /production_statuses/1 to production_statuses#show" do
    expect(get: "/production_statuses/1").to route_to(controller: "production_statuses", action: "show", id: "1")
  end
  
  it "routes /production_statuses/new to production_statuses#new" do
    expect(get: "/production_statuses/new").to route_to(controller: "production_statuses", action: "new")
  end

  it "routes /production_statuses to production_statuses#create" do
    expect(post: "/production_statuses").to route_to(controller: "production_statuses", action: "create")
  end

  it "routes /production_statuses/1/edit to production_statuses#edit" do
    expect(get: "/production_statuses/1/edit").to route_to(controller: "production_statuses", action: "edit", id: "1")
  end

  it "routes /production_statuses/1 to production_statuses#update" do
    expect(put: "/production_statuses/1").to route_to(controller: "production_statuses", action: "update", id: "1")
  end
end