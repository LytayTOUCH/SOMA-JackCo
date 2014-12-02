require 'spec_helper'

describe 'routing to resources' do
  it "routes /resources/1 to resources#show" do
    expect(get: "/resources/1").to route_to(controller: "resources", action: "show", id: "1")
  end
  
  it "routes /resources/new to resources#new" do
    expect(get: "/resources/new").to route_to(controller: "resources", action: "new")
  end

  it "routes /resources to resources#create" do
    expect(post: "/resources").to route_to(controller: "resources", action: "create")
  end

  it "routes /resources/1/edit to resources#edit" do
    expect(get: "/resources/1/edit").to route_to(controller: "resources", action: "edit", id: "1")
  end

  it "routes /resources/1 to resources#update" do
    expect(put: "/resources/1").to route_to(controller: "resources", action: "update", id: "1")
  end
end