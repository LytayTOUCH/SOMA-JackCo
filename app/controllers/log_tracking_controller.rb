class LogTrackingController < ApplicationController
  def index
  	@logs = Log.joins(:user).order("logs.user_id, logs.created_at desc")
  end
end
