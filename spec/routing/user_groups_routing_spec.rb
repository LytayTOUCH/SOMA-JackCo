require 'spec_helper'

describe 'routing to user_groups' do
  it "routes /user_groups/1 to user_groups#show" do
    expect(get: "/user_groups/1").to route_to(controller: "user_groups", action: "show", id: "1")
  end
  
  it "routes /user_groups/new to user_groups#new" do
    expect(get: "/user_groups/new").to route_to(controller: "user_groups", action: "new")
  end

  it "routes /user_groups to user_groups#create" do
    expect(post: "/user_groups").to route_to(controller: "user_groups", action: "create")
  end

  it "routes /user_groups/1/edit to user_groups#edit" do
    expect(get: "/user_groups/1/edit").to route_to(controller: "user_groups", action: "edit", id: "1")
  end

  it "routes /user_groups/1 to user_groups#update" do
    expect(put: "/user_groups/1").to route_to(controller: "user_groups", action: "update", id: "1")
  end
end