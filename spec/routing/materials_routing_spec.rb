require 'spec_helper'

describe 'routing to materials' do
  it "routes /materials to materials#index" do
    expect(get: "/materials").to route_to(controller: "materials", action: "index")
  end

  it "routes /materials/new to materials#new" do
    expect(get: "/materials/new").to route_to(controller: "materials", action: "new")
  end

  it "routes /materials to materials#create" do
    expect(post: "/materials").to route_to(controller: "materials", action: "create")
  end

  it "routes /materials/1/edit to materials#edit" do
    expect(get: "/materials/1/edit").to route_to(controller: "materials", action: "edit", id: "1")
  end

  it "routes /materials/1 to materials#update" do
    expect(put: "/materials/1").to route_to(controller: "materials", action: "update", id: "1")
  end
end
