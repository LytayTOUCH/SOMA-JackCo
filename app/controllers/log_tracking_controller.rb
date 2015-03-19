class LogTrackingController < ApplicationController
  def index
  	@users = User.all
  end
end
