class CoconutsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Coconuts", :coconuts_path

  def index
    begin
      @coconut = Coconut.new

      if params[:coconut] and params[:coconut][:code] and !params[:coconut][:code].nil?
        @coconuts = Coconut.find_by_coconut_code(params[:coconut][:code]).page(params[:page]).per(5)
      else
        @coconuts = Coconut.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @coconut = Coconut.new
    @stages = ProductionStage.all
    @fields = Field.all
  end

  def create
    begin
      @coconut = Coconut.new(coconut_params)
      puts "=============++++================="
      puts params[:active]
      puts "=================================="


      if @coconut.save
        create_log current_user.uuid, "Created New Coconut", @coconut
        flash[:notice] = "Coconut saved successfully"
        redirect_to coconuts_path
      else
        flash[:notice] = "Coconut can't be saved"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @coconut = Coconut.find(params[:id])
    @fields = Field.all
    add_breadcrumb @coconut.code, :edit_coconut_path
  end

  def update
    begin
      @coconut = Coconut.find(params[:id])

      if @coconut.update_attributes(coconut_params)
        if params[:coconut][:active] == "false"
          create_log current_user.uuid, "Deactivated Coconut", @coconut
        elsif params[:coconut][:active] == "true"
          create_log current_user.uuid, "Activated Coconut", @coconut
        end

        if params[:coconut][:active] == "1" or params[:coconut][:active] == "0"
          create_log current_user.uuid, "Updated Coconut", @coconut  
        end 
        flash[:notice] = "Coconut updated"
        redirect_to coconuts_path
      else
        flash[:notice] = "Coconut can't be updated"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def destroy
    @coconut = Coconut.find(params[:id])
    @coconut.destroy

    respond_to do |format|
      format.html { redirect_to coconuts_path, :notice => 'Coconut was successfully deleted.' }
      format.json { render json: @coconut, status: :created, location: @coconut }
    end
  end

  private
  def coconut_params
    params.require(:coconut).permit(:code, :coco_type, :planting_date, :field_uuid, :stage_uuid, :note, :active)
  end
end
