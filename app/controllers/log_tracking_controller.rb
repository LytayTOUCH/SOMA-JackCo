class LogTrackingController < ApplicationController
  def index
    @logs = Log.joins(:user).order("logs.created_at desc")
  end
end
