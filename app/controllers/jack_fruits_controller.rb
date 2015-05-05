class JackFruitsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "All Jack Fruits", :jack_fruits_path

  def index
    begin
      @jack_fruit = JackFruit.new

      if params[:jack_fruit] and params[:jack_fruit][:code] and !params[:jack_fruit][:code].nil?
        @jack_fruits = JackFruit.find_by_jack_fruit_code(params[:jack_fruit][:code]).page(params[:page]).per(5)
      else
        @jack_fruits = JackFruit.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def show
    @jack_fruit = JackFruit.find(params[:id])
    add_breadcrumb @jack_fruit.code, :jack_fruit_path
  end

  def new
    @jack_fruit = JackFruit.new
    @stages = ProductionStage.all
    @fields = Field.all
  end

  def create
    @jack_fruit = JackFruit.new(jack_fruit_params)

    if @jack_fruit.save
      create_log current_user.uuid, "Created New JackFruit", @jack_fruit
      flash[:notice] = "JackFruit saved successfully"
      redirect_to jack_fruits_path
    else
      flash[:notice] = "JackFruit can't be saved"
      render 'new'
    end
  end

  def edit
    @jack_fruit = JackFruit.find(params[:id])
    # @stages = Stage.where(fruit_type: 'jackfruit')
    @fields = Field.all
    add_breadcrumb @jack_fruit.code, :edit_jack_fruit_path
  end

  def update
    @jack_fruit = JackFruit.find(params[:id])

    if @jack_fruit.update_attributes(jack_fruit_params)
      if params[:jackfruit][:active] == "false"
          create_log current_user.uuid, "Deactivated JackFruit", @jackfruit
        elsif params[:jackfruit][:active] == "true"
          create_log current_user.uuid, "Activated JackFruit", @jackfruit
        end

        if params[:jackfruit][:active] == "1" or params[:jackfruit][:active] == "0"
          create_log current_user.uuid, "Updated JackFruit", @jackfruit  
        end 
      flash[:notice] = "JackFruit updated"
      redirect_to jack_fruits_path
    else
      flash[:notice] = "JackFruit can't be updated."
      render 'edit'
    end
  end

  def destroy
    @jack_fruit = JackFruit.find(params[:id])
    create_log current_user.uuid, "Deleted JackFruit", @jack_fruit

    @jack_fruit.destroy

    respond_to do |format|
      format.html { redirect_to jack_fruits_path, :notice => 'JackFruit was successfully deleted.' }
      format.json { render json: @jack_fruit, status: :created, location: @jack_fruit }
    end
  end

  private
  def jack_fruit_params
    params.require(:jack_fruit).permit(:code, :grown_by, :jack_fruit_type, :planting_date, :field_uuid, :stage_uuid, :note, :active)
  end

end
