class PhasesController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Phases", :phases_path
  
  def index
    begin
      @phase = Phase.new

      if params[:phase] and params[:phase][:name] and !params[:phase][:name].nil?
        @phases = Phase.find_by_phase_name(params[:phase][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @phases = Phase.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @phase = Phase.new
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @phase = Phase.new(phase_params)

      if @phase.save!
        flash[:notice] = "Phase saved successfully"
        redirect_to phases_path
      else
        flash[:notice] = "Phase can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @phase = Phase.find(params[:id])
      add_breadcrumb @phase.name, :edit_phase_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @phase = Phase.find(params[:id])

      if @phase.update_attributes!(phase_params)
        flash[:notice] = "Phase updated"
        redirect_to phases_path
      else
        flash[:notice] = "Phase can't be updated"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def phase_params
    params.require(:phase).permit(:name, :note, :active)
  end
end
