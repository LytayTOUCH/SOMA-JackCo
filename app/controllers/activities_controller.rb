class ActivitiesController < ApplicationController
  load_and_authorize_resource
  def index
    begin
      @activity = Activity.new

      if params[:activity] and params[:activity][:starts_at] and !params[:activity][:starts_at].nil?
        @paginate_activities = Activity.find_by_date(params[:activity][:starts_at]).page(params[:page]).per(5)
      else
        @paginate_activities = Activity.page(params[:page]).per(5)
      end

      activities_json
    rescue Exception => e
      puts e
    end
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
    @activity_types = ActivityType.all
    @activity.starts_at = params[:current_date]
  end

  def create
    begin
      @activity = Activity.new(activity_params)
      if @activity.save!
        flash[:notice] = "Activity saved successfully"
        redirect_to calendars_path
      else
        flash[:notice] = "Activity can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    @activity_types = ActivityType.all
  end

  def update
    begin
      @activity = Activity.find(params[:id])
      if @activity.update_attributes!(activity_params)
        flash[:notice] = "Activity saved successfully"
        redirect_to calendars_path
      else
        flash[:notice] = "Activity can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    if @activity.destroy!
      flash[:notice] = "Activity deleted successfully"
      redirect_to calendars_path
    else
      flash[:notice] = "Activity can't delete"
      redirect_to :back
    end
  end

  private
  def activities_json
    activities = Activity.all

    respond_to do |format|
      format.html
      format.json { render json: activities }
    end
  end

  def activity_params
    params.require(:activity).permit(:starts_at, :note, :activity_type_uuid)
  end
end
