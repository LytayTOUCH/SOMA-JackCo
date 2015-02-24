require 'spec_helper'

describe 'routing to phases' do
  it "routes /phases/1 to phases#show" do
    expect(get: "/phases/1").to route_to(controller: "phases", action: "show", id: "1")
  end
  
  it "routes /phases/new to phases#new" do
    expect(get: "/phases/new").to route_to(controller: "phases", action: "new")
  end

  it "routes /phases to phases#create" do
    expect(post: "/phases").to route_to(controller: "phases", action: "create")
  end

  it "routes /phases/1/edit to phases#edit" do
    expect(get: "/phases/1/edit").to route_to(controller: "phases", action: "edit", id: "1")
  end

  it "routes /phases/1 to phases#update" do
    expect(put: "/phases/1").to route_to(controller: "phases", action: "update", id: "1")
  end
end