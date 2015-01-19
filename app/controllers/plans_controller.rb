class PlansController < ApplicationController
  before_filter :set_title
  load_and_authorize_resource except: :create
  
  def index
    begin
      @plan = Plan.new

      if params[:plan] and params[:plan][:name] and !params[:plan][:name].nil?
        @plans = Plan.find_by_name(params[:plan][:name]).page(params[:page]).per(5)
      else
        @plans = Plan.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @plan = Plan.new
  end

  def create
    begin
      @plan = Plan.new(plan_params)

      if @plan.save!
        flash[:notice] = "Plan saved successfully"
        redirect_to plans_path
      else
        flash[:notice] = "Plan can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    begin
      @plan = Plan.find(params[:id])

      if @plan.update_attributes!(plan_params)
        flash[:notice] = "Plan updated successfully"
        redirect_to plans_path
      else
        flash[:notice] = "Plan can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    if @plan.destroy!
      flash[:notice] = "Plan deleted successfully"
      redirect_to plans_path
    else
      flash[:notice] = "Plan can't delete"
      redirect_to :back
    end
  end

  private
  def set_title
    content_for :title, "Plan"
  end

  def plan_params
    params.require(:plan).permit(:name, :quantity, :unit, :year)
  end

end
