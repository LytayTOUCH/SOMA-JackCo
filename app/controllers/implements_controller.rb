class ImplementsController < ApplicationController
  load_and_authorize_resource except: :create
  
  def new
    begin
      @implement = Implement.new
      @implement_types = ImplementType.all
    rescue Exception => e
      puts e
    end
  end

  def show
    begin
      @implement = ImplementDecorator.new(Implement.find(params[:id]))
      @maintenances = Maintenance.find_limit_10
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @implement = Implement.new(implement_params)

      if @implement.save!
        create_log current_user.uuid, "Created New Implement", @implement
        flash[:notice] = "Implement saved successfully"
        redirect_to :back
      else
        flash[:notice] = "Implement can't be saved"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @implement = Implement.find(params[:id])
      @implement_types = ImplementType.all
      add_breadcrumb @implement.name, :edit_implement_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @implement = Implement.find(params[:id])

      if @implement.update_attributes!(implement_params)
        create_log current_user.uuid, "Updated Implement", @implement
        flash[:notice] = "Implement updated successfully"
        redirect_to implement_path
      else
        flash[:notice] = "Implement can't be updated"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def implement_params
    params.require(:implement).permit(:name, :year, :implement_type_uuid, :value, :own, :note, :photo)
  end
end
