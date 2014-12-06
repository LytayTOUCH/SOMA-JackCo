class MaterialsController < ApplicationController
  def index
    @materials = Material.all
  end

  def new
    @material = Material.new
    @suppliers = Supplier.all
  end

  def create
    @material = Material.new(material_params)

    if @material.save!
      flash[:notice] = "Material saved successfully"
      redirect_to :back
    else
      flash[:notice] = "Material can't save"
      redirect_to :back
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])

    if @material.update_attributes!(material_params)
      flash[:notice] = "Material updated successfully"
      redirect_to materials_path
    else
      flash[:notice] = "Material category can't update"
      redirect_to :back
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
