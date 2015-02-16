require 'spec_helper'

describe 'routing to permissions' do
  it "routes /permissions/1 to permissions#show" do
    expect(get: "/permissions/1").to route_to(controller: "permissions", action: "show", id: "1")
  end
  
  it "routes /permissions/new to permissions#new" do
    expect(get: "/permissions/new").to route_to(controller: "permissions", action: "new")
  end

  it "routes /permissions to permissions#create" do
    expect(post: "/permissions").to route_to(controller: "permissions", action: "create")
  end

  it "routes /permissions/1/edit to permissions#edit" do
    expect(get: "/permissions/1/edit").to route_to(controller: "permissions", action: "edit", id: "1")
  end

  it "routes /permissions/1 to permissions#update" do
    expect(put: "/permissions/1").to route_to(controller: "permissions", action: "update", id: "1")
  end
end