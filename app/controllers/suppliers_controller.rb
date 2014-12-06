class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save!
      flash[:notice] = "Supplier saved successfully"
      redirect_to :back
    else
      flash[:notice] = "Supplier can't save"
      redirect_to :back
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])

    if @supplier.update_attributes!(supplier_params)
      flash[:notice] = "Supplier updated successfully"
      redirect_to supplier_path
    else
      flash[:notice] = "supplier can't update"
      redirect_to :back
    end
  end

  private
  def supplier_params
    params.require(:supplier).permit(:name, :contact_person, :phone, :time_spent, :email, :address, :active)
  end
end
