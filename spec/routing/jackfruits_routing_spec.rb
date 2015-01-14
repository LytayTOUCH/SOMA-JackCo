require 'spec_helper'

describe 'routing to jack_fruits' do
  it "routes /jack_fruits/1 to jack_fruits#show" do
    expect(get: "/jack_fruits/1").to route_to(controller: "jack_fruits", action: "show", id: "1")
  end
  
  it "routes /jack_fruits/new to jack_fruits#new" do
    expect(get: "/jack_fruits/new").to route_to(controller: "jack_fruits", action: "new")
  end

  it "routes /jack_fruits to jack_fruits#create" do
    expect(post: "/jack_fruits").to route_to(controller: "jack_fruits", action: "create")
  end

  it "routes /jack_fruits/1/edit to jack_fruits#edit" do
    expect(get: "/jack_fruits/1/edit").to route_to(controller: "jack_fruits", action: "edit", id: "1")
  end

  it "routes /jack_fruits/1 to jack_fruits#update" do
    expect(put: "/jack_fruits/1").to route_to(controller: "jack_fruits", action: "update", id: "1")
  end
end