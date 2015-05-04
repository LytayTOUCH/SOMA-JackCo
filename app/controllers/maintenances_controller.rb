class MaintenancesController < ApplicationController
  load_and_authorize_resource except: :create
  
  def new
    begin
      @maintenance = Maintenance.new(machinery_uuid: params[:machinery_uuid],maintenance_type: params[:maintenance_type])
      @labors = Labor.all
      @default_labor = Labor.first
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @maintenance = Maintenance.new(maintenance_params)

      if @maintenance.save!
        create_log current_user.uuid, "Created New Maintenance", @maintenance
        flash[:notice] = "Maintenance saved successfully"
        redirect_to :back
      else
        flash[:notice] = "Maintenance can't be saved"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def maintenance_params
    params.require(:maintenance).permit(:machinery_uuid, :labor_uuid, :engine_hours, :time_spent, :note, :maintenance_type)
  end
end
