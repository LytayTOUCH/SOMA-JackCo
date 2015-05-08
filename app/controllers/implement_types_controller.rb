class ImplementTypesController < ApplicationController
  before_filter :set_title
  load_and_authorize_resource except: :create

  add_breadcrumb "All Implement Types", :implement_types_path
  
  def index
    begin
      @implement_type = ImplementType.new

      if params[:implement_type] and params[:implement_type][:name] and !params[:implement_type][:name].nil?
        @implement_types = ImplementType.find_by_implement_type_name(params[:implement_type][:name]).page(params[:page]).per(5)
      else
        @implement_types = ImplementType.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @implement_type = ImplementType.new
  end

  def create
    begin
      @implement_type = ImplementType.new(implement_type_params)
      create_log current_user.uuid, "Created New Implement Type", @implement_type

      if @implement_type.save!
        flash[:notice] = "ImplementType saved successfully"
        redirect_to :back
      else
        flash[:notice] = "ImplementType can't be saved"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @implement_type = ImplementType.find(params[:id])
    add_breadcrumb @implement_type.name, :edit_implement_type_path
  end

  def update
    begin
      @implement_type = ImplementType.find(params[:id])
      create_log current_user.uuid, "Updated Implement Type", @implement_type

      if @implement_type.update_attributes!(implement_type_params)
        flash[:notice] = "Implement Type updated successfully"
        redirect_to implement_types_path
      else
        flash[:notice] = "Implement Type category can't be updated"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def set_title
    content_for :title, "Implement Type"
  end
  def implement_type_params
    params.require(:implement_type).permit(:name, :note)
  end
end
