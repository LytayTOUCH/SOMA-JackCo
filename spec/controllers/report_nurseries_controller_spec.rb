require 'spec_helper'

describe ReportNurseriesController do

  describe "GET 'coconut_index'" do
    it "returns http success" do
      get 'coconut_index'
      response.should be_success
    end
  end

end
