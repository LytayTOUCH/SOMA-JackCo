class CoconutsController < ApplicationController
  load_and_authorize_resource except: :create

  def index
    begin
      @coconut = Coconut.new

      if params[:coconut] and params[:coconut][:code] and !params[:coconut][:code].nil?
        @coconuts = Coconut.find_by_code(params[:coconut][:code]).page(params[:page]).per(5)
      else
        @coconuts = Coconut.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @coconut = Coconut.new
    @stages = Stage.where(fruit_type: 'coconut')
  end

  def create
    @coconut = Coconut.new(coconut_params)

    if @coconut.save!
      flash[:notice] = "coconut saved successfully"
      redirect_to coconuts_path
    else
      flash[:notice] = "coconut can't be saved"
      redirect_to :back
    end
  end

  def edit
    @coconut = Coconut.find(params[:id])
    @stages = Stage.where(fruit_type: 'coconut')
  end

  def update
    @coconut = Coconut.find(params[:id])
    if @coconut.update_attributes!(coconut_params)
      flash[:notice] = "coconut updated"
      redirect_to coconuts_path
    else
      redirect_to :back
    end
  end

  private
  def coconut_params
    params.require(:coconut).permit(:code, :status, :coco_type, :growing_date, :field_uuid, :stage_uuid, :note)
  end

end
