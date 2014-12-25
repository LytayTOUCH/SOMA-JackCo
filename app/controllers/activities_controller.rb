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
      format.json { render :json => @activities }
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
    @activity_type_name = params[:activity_type]
    @activity_type_uuid = ActivityType.find_by(name: params[:activity_type]).uuid
    @activity = Activity.new
    @activity_types = ActivityType.all
    @activity.starts_at = params['current-date']
  end

  def create
    begin
      @activity = Activity.new(activity_params)

      respond_to do |format|
        if @activity.save!
          format.html { redirect_to calendars_path, :notice => 'Activity was successfully created.' }
          format.json { render json: @activity, status: :created, location: @activity }
          puts "==========================================================="
          puts json: @activity
          puts "==========================================================="
        else
          flash[:notice] = "Activity type can't save"
          format.html { render action: "new" }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end  
    rescue Exception => e
      puts e
    end
  end

  def edit
    @activity_type_name = params[:activity_type]
    @activity = Activity.find(params[:id])
    @activity_types = ActivityType.all
  end

  def update
    begin
      @activity = Activity.find(params[:id])

      respond_to do |format|
        if @activity.update_attributes!(activity_params)
          format.html { redirect_to calendars_path, :notice => 'Activity was successfully edited.' }
          format.json { render json: @activity, status: :created, location: @activity }
        else
          redirect_to :back
        end
      end  
    rescue Exception => e
      puts e
    end
  end

  private
  def activity_params
    params.require(:activity).permit(:starts_at, :note, :activity_type_uuid)
  end
end