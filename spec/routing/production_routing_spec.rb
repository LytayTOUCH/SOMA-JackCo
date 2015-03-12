require 'spec_helper'

describe 'routing to productions' do
  it "routes /productions/1 to productions#show" do
    expect(get: "/productions/1").to route_to(controller: "productions", action: "show", id: "1")
  end
  
  it "routes /productions/new to productions#new" do
    expect(get: "/productions/new").to route_to(controller: "productions", action: "new")
  end

  it "routes /productions to productions#create" do
    expect(post: "/productions").to route_to(controller: "productions", action: "create")
  end

  it "routes /productions/1/edit to productions#edit" do
    expect(get: "/productions/1/edit").to route_to(controller: "productions", action: "edit", id: "1")
  end

  it "routes /productions/1 to productions#update" do
    expect(put: "/productions/1").to route_to(controller: "productions", action: "update", id: "1")
  end
end