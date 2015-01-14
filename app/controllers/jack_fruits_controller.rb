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
    @jack_fruit = JackFruit.new(coconut_params)

    if @jack_fruit.save!
      flash[:notice] = "jack_fruit saved successfully"
      redirect_to jack_fruits_path
    else
      flash[:notice] = "jack_fruit can't be saved"
      redirect_to :back
    end
  end

  def edit
    @coconut = JackFruit.find(params[:id])
    @stages = Stage.where(fruit_type: 'jackfruit')
  end

  def update
    @jack_fruit = JackFruit.find(params[:id])
    if @jack_fruit.update_attributes!(jack_fruit_params)
      flash[:notice] = "jack_fruit updated"
      redirect_to jack_fruits_path
    else
      redirect_to :back
    end
  end

  private
  def jack_fruit_params
    params.require(:coconut).permit(:code, :status, :jack_fruit_type, :growing_date, :field_uuid, :stage_uuid, :note)
  end

end
