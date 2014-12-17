require 'spec_helper'

describe 'routing to suppliers' do
  it "routes /suppliers to suppliers#index" do
    expect(get: "/suppliers").to route_to(controller: "suppliers", action: "index")
  end

  it "routes /suppliers/new to suppliers#new" do
    expect(get: "/suppliers/new").to route_to(controller: "suppliers", action: "new")
  end

  it "routes /suppliers to suppliers#create" do
    expect(post: "/suppliers").to route_to(controller: "suppliers", action: "create")
  end

  it "routes /suppliers/1/edit to suppliers#edit" do
    expect(get: "/suppliers/1/edit").to route_to(controller: "suppliers", action: "edit", id: "1")
  end

  it "routes /suppliers/1 to suppliers#update" do
    expect(put: "/suppliers/1").to route_to(controller: "suppliers", action: "update", id: "1")
  end
end
