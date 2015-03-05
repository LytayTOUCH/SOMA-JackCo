class MaterialsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "All Materials", :materials_path

  def index
    begin
      @material = Material.new

      if params[:material] and params[:material][:name] and !params[:material][:name].nil?
        @materials = Material.find_by_material_name(params[:material][:name]).page(params[:page]).per(5)
      else
        @materials = Material.page(params[:page]).order('updated_at DESC').per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @material = Material.new
      # @suppliers = Supplier.all
      @material_categories = MaterialCategory.all
      @unit_measurements = UnitOfMeasurement.all
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @material = Material.new(material_params)

      if @material.save
        flash[:notice] = "Material saved successfully"
        # redirect_to :back
        redirect_to materials_path
      else
        flash[:notice] = "Material can't save"
        # redirect_to :back
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @material = Material.find(params[:id])
      # @suppliers = Supplier.all
      @material_categories = MaterialCategory.all
      @unit_measurements = UnitOfMeasurement.all
      add_breadcrumb @material.name, :edit_material_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @material = Material.find(params[:id])

      if @material.update_attributes(material_params)
        flash[:notice] = "Material updated successfully"
        redirect_to materials_path
      else
        flash[:notice] = "Material can't update"
        # redirect_to :back
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def get_material_data
    @material_data = Material.where(material_cate_uuid: params[:material_cate_uuid])
    render :json => @material_data
  end

  # def new_supplier
  #   begin
  #     @supplier = Supplier.new
  #   rescue Exception => e
  #     puts e
  #   end
  # end

  private
  def material_params
    params.require(:material).permit(:name, :material_cate_uuid, :unit_measure_uuid, :supplier, :note)
  end
end
