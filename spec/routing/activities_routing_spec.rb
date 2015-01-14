require 'spec_helper'

describe 'routing to activities' do
  it "routes /activities/1 to activities#show" do
    expect(get: "/activities/1").to route_to(controller: "activities", action: "show", id: "1")
  end

  it "routes /activities/new to activities#new" do
    expect(get: "/activities/new").to route_to(controller: "activities", action: "new")
  end

  it "routes /activities to activities#create" do
    expect(post: "/activities").to route_to(controller: "activities", action: "create")
  end

  it "routes /activities/1/edit to activities#edit" do
    expect(get: "/activities/1/edit").to route_to(controller: "activities", action: "edit", id: "1")
  end

  it "routes /activities/1 to activities#update" do
    expect(put: "/activities/1").to route_to(controller: "activities", action: "update", id: "1")
  end
end
