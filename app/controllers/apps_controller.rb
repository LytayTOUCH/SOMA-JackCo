class AppsController < ApplicationController
  add_breadcrumb "All Applications", :apps_path
  
  def index
    @apps = App.order("planting_project_id, app_type")
  end
  
  def new
    @app = App.new
  end
  
  def create
    @app = App.new(app_params)

    if @app.save
      create_log current_user.uuid, "Created New Application", @app
      flash[:notice] = "Application saved successfully"
      redirect_to apps_path
    else
      flash[:notice] = "Application can't be saved"
      render "new"
    end
  end
  
  def edit
    @app = App.find(params[:id])
    add_breadcrumb @app.name, :edit_app_path
  end
  
  def update
    @app = App.find(params[:id])

    if @app.update_attributes(app_params)
      create_log current_user.uuid, "Updated Application", @app 
      flash[:notice] = "Application updated successfully"
      redirect_to apps_path
    else
      flash[:notice] = "Application can't be updated"
      render 'edit'
    end
  end
  
  def get_application_data
    render json: App.where("planting_project_id = ?", params[:planting_project_id]).order(:created_at), :include => :app_descriptions
  end
  
  private
  def app_params
    params.require(:app).permit(:name, :app_type, :note, :planting_project_id)
  end
end
