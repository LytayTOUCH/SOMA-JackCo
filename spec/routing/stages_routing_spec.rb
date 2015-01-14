require 'spec_helper'

describe 'routing to stages' do
  it "routes /stages/1 to stages#show" do
    expect(get: "/stages/1").to route_to(controller: "stages", action: "show", id: "1")
  end
  
  it "routes /stages/new to stages#new" do
    expect(get: "/stages/new").to route_to(controller: "stages", action: "new")
  end

  it "routes /stages to stages#create" do
    expect(post: "/stages").to route_to(controller: "stages", action: "create")
  end

  it "routes /stages/1/edit to stages#edit" do
    expect(get: "/stages/1/edit").to route_to(controller: "stages", action: "edit", id: "1")
  end

  it "routes /stages/1 to stages#update" do
    expect(put: "/stages/1").to route_to(controller: "stages", action: "update", id: "1")
  end
end