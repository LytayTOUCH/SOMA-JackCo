require 'spec_helper'

describe 'routing to implement_types' do
  it "routes /labors to implement_types#index" do
    expect(get: "/implement_types").to route_to(controller: "implement_types", action: "index")
  end

  it "routes /implement_types/new to implement_types#new" do
    expect(get: "/implement_types/new").to route_to(controller: "implement_types", action: "new")
  end

  it "routes /implement_types to implement_types#create" do
    expect(post: "/implement_types").to route_to(controller: "implement_types", action: "create")
  end

  it "routes /implement_types/1/edit to implement_types#edit" do
    expect(get: "/implement_types/1/edit").to route_to(controller: "implement_types", action: "edit", id: "1")
  end

  it "routes /implement_types/1 to implement_types#update" do
    expect(put: "/implement_types/1").to route_to(controller: "implement_types", action: "update", id: "1")
  end
end
