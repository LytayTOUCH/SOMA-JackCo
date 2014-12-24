class ActivitiesController < ApplicationController
  respond_to :html

  def index
    begin
      @activity = Activity.new

      if params[:activity] and params[:activity][:name] and !params[:activity][:name].nil?
        @activities = Activity.find_by_name(params[:activity][:name]).page(params[:page]).per(5)
      else
        @activities = Activity.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @activitys }
    end
  end

  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  def new
    @activity = Activity.new
    @activity_type = ActivityType.all
    @activity.date = params['current-date']
  end

  def create
    begin
      @activity = Activity.new(activity_params)

      if @activity.save!
        flash[:notice] = "Activity type saved successfully"
        format.html { redirect_to calendars_path, :notice => 'Activity was successfully created.' }
        format.json { render :json => @activity, :status => :created, :location => @activity }
      else
        flash[:notice] = "Activity type can't save"
        format.html { render action: "new" }
        format.json { render :json => @activity.errors, :status => :unprocessable_entity }
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    @activity_type = ActivityType.all
  end

  def update
    begin
      @activity = Activity.find(params[:id])

      if @activity.update_attributes!(activity_params)
        flash[:notice] = "Activity updated"
        redirect_to activitys_path
      else
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def activity_params
    params.require(:activity).permit(:name, :note, :active)
  end
end
