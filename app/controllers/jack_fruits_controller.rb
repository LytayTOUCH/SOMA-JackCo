class JackFruitsController < ApplicationController
  load_and_authorize_resource except: :create
  
  def index
    begin
      @jack_fruit = JackFruit.new

      if params[:jack_fruit] and params[:jack_fruit][:code] and !params[:jack_fruit][:code].nil?
        @jack_fruits = JackFruit.find_by_code(params[:jack_fruit][:code]).page(params[:page]).per(5)
      else
        @jack_fruits = JackFruit.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @jack_fruit = JackFruit.new
    @stages = Stage.where(fruit_type: 'jackfruit')
  end

  def create
    @jack_fruit = JackFruit.new(jack_fruit_params)

    if @jack_fruit.save!
      flash[:notice] = "JackFruit saved successfully"
      redirect_to jack_fruits_path
    else
      flash[:notice] = "JackFruit can't be saved"
      redirect_to :back
    end
  end

  def edit
    @jack_fruit = JackFruit.find(params[:id])
    @stages = Stage.where(fruit_type: 'jackfruit')
  end

  def update
    @jack_fruit = JackFruit.find(params[:id])
    if @jack_fruit.update_attributes!(jack_fruit_params)
      flash[:notice] = "JackFruit updated"
      redirect_to jack_fruits_path
    else
      redirect_to :back
    end
  end

  def destroy
    @jack_fruit = JackFruit.find(params[:id])
    @jack_fruit.destroy

    respond_to do |format|
      format.html { redirect_to jack_fruits_path, :notice => 'JackFruit was successfully deleted.' }
      format.json { render json: @jack_fruit, status: :created, location: @jack_fruit }
    end
  end

  private
  def jack_fruit_params
    params.require(:jack_fruit).permit(:code, :grown_by, :jack_fruit_type, :planting_date, :field_uuid, :stage_uuid, :note)
  end

end
