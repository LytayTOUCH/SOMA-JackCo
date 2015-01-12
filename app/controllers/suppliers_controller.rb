class SuppliersController < ApplicationController
  load_and_authorize_resource
  
  def index
    begin
      @supplier = Supplier.new

      if params[:supplier] and params[:supplier][:name] and !params[:supplier][:name].nil?
        @suppliers = Supplier.find_by_name(params[:supplier][:name]).page(params[:page]).per(5)
      else
        @suppliers = Supplier.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @supplier = Supplier.new
  end

  def create
    begin
      @supplier = Supplier.new(supplier_params)

      if @supplier.save!
        flash[:notice] = "Supplier saved successfully"
        redirect_to :back
      else
        flash[:notice] = "Supplier can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    begin
      @supplier = Supplier.find(params[:id])

      if @supplier.update_attributes!(supplier_params)
        flash[:notice] = "Supplier updated successfully"
        redirect_to suppliers_path
      else
        flash[:notice] = "supplier can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def supplier_params
    params.require(:supplier).permit(:name, :contact_person, :phone, :time_spent, :email, :address, :active)
  end
end
