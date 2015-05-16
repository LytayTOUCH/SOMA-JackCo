require 'spec_helper'

describe ReportClassificationsController do

  describe "GET 'coconut_index'" do
    it "returns http success" do
      get 'coconut_index'
      response.should be_success
    end
  end

  describe "GET 'jackfruit_index'" do
    it "returns http success" do
      get 'jackfruit_index'
      response.should be_success
    end
  end

end
