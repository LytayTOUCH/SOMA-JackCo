require 'spec_helper'

describe 'routing to labors' do
  it "routes /labors to labors#index" do
    expect(get: "/labors").to route_to(controller: "labors", action: "index")
  end

  it "routes /labors/new to labors#new" do
    expect(get: "/labors/new").to route_to(controller: "labors", action: "new")
  end

  it "routes /labors to labors#create" do
    expect(post: "/labors").to route_to(controller: "labors", action: "create")
  end

  it "routes /labors/1/edit to labors#edit" do
    expect(get: "/labors/1/edit").to route_to(controller: "labors", action: "edit", id: "1")
  end

  it "routes /labors/1 to labors#update" do
    expect(put: "/labors/1").to route_to(controller: "labors", action: "update", id: "1")
  end
end
