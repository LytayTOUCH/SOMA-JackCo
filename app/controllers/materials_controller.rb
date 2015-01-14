class MaterialsController < ApplicationController
  load_and_authorize_resource except: :create
  
  def index
    begin
      @material = Material.new

      if params[:material] and params[:material][:name] and !params[:material][:name].nil?
        @materials = Material.find_by_name(params[:material][:name]).page(params[:page]).per(5)
      else
        @materials = Material.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @material = Material.new
    @suppliers = Supplier.all
  end

  def create
    begin
      @material = Material.new(material_params)

      if @material.save!
        flash[:notice] = "Material saved successfully"
        redirect_to :back
      else
        flash[:notice] = "Material can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @material = Material.find(params[:id])
    @suppliers = Supplier.all
  end

  def update
    begin
      @material = Material.find(params[:id])

      if @material.update_attributes!(material_params)
        flash[:notice] = "Material updated successfully"
        redirect_to materials_path
      else
        flash[:notice] = "Material category can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def new_supplier
    @supplier = Supplier.new
  end

  private
  def material_params
    params.require(:material).permit(:name, :quantity, :unit, :supplier_uuid, :warehouse_uuid)
  end
end
