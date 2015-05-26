class InputUsesController < ApplicationController
  authorize_resource :class => false
  has_scope :start_date, :using => [:started_at, :ended_at] , :type => :hash

  def index
    if !params[:filter].nil? && !params[:filter][:day].nil?
      if params[:filter][:day] == "today"
        @start_date = Date.today
        @end_date = Date.today
      elsif params[:filter][:day] == "week"
        @start_date = Date.today.beginning_of_week
        @end_date = Date.today.end_of_week
      elsif params[:filter][:day] == "month"
        @start_date = Date.today.beginning_of_month
        @end_date = Date.today.end_of_month
      elsif params[:filter][:day] == "year"
        @start_date = Date.today.beginning_of_year
        @end_date = Date.today.end_of_year
      else
        @start_date = Date.strptime(params[:filter][:start_date], "%Y-%m-%d")
        @end_date = Date.strptime(params[:filter][:end_date], "%Y-%m-%d")
      end
    end
  end
end