class CalendarsController < ApplicationController

  respond_to :html

  def index
    @activities = Activity.all

    # respond_to do |format|
    #   format.html do
    #     redirect_to '/'
    #   end
    #   format.json { render :json => @activities.to_json }
    # end
  end

  def new
    @activity = Activity.new
    @activity_types = ActivityType.all
    @activity.starts_at = params[:current_date]
  end

  def create
    begin
      @activity = Activity.new(activity_params)

      respond_to do |format|
        if @activity.save!
          format.html { redirect_to calendars_path, :notice => 'Activity was successfully created.' }
          format.json { render :json => @activity, :status => :created, :location => @activity }
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

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    
    respond_to do |format|
      format.html { redirect_to calendars_path, :notice => 'Activity was successfully deleted.' }
      format.json { render json: @activity, status: :created, location: @activity }
    end
  end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end
    
    def activity_params
      params.require(:activity).permit(:starts_at, :note, :activity_type_uuid)
    end
end
