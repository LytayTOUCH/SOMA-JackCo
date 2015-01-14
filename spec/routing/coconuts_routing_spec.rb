require 'spec_helper'

describe 'routing to coconuts' do
  it "routes /coconuts/1 to coconuts#show" do
    expect(get: "/coconuts/1").to route_to(controller: "coconuts", action: "show", id: "1")
  end
  
  it "routes /coconuts/new to coconuts#new" do
    expect(get: "/coconuts/new").to route_to(controller: "coconuts", action: "new")
  end

  it "routes /coconuts to coconuts#create" do
    expect(post: "/coconuts").to route_to(controller: "coconuts", action: "create")
  end

  it "routes /coconuts/1/edit to coconuts#edit" do
    expect(get: "/coconuts/1/edit").to route_to(controller: "coconuts", action: "edit", id: "1")
  end

  it "routes /coconuts/1 to coconuts#update" do
    expect(put: "/coconuts/1").to route_to(controller: "coconuts", action: "update", id: "1")
  end
end