class LogTrackingController < ApplicationController
  def index
  	@versions = Version.joins(:user).order("versions.whodunnit, versions.created_at desc")
  end
end
