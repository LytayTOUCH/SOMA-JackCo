class SuppliersController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Suppliers", :suppliers_path
  
  def index
    begin
      @supplier = Supplier.new

      if params[:supplier] and params[:supplier][:name] and !params[:supplier][:name].nil?
        @suppliers = Supplier.find_by_supplier_name(params[:supplier][:name]).page(params[:page]).per(5)
      else
        @suppliers = Supplier.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @supplier = Supplier.new
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @supplier = Supplier.new(supplier_params)

      if @supplier.save!
        create_log current_user.uuid, "Created New Supplier", @supplier
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
    begin
      @supplier = Supplier.find(params[:id])
      add_breadcrumb @supplier.name, :edit_supplier_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @supplier = Supplier.find(params[:id])

      if @supplier.update_attributes!(supplier_params)
        if params[:supplier][:active] == "false"
          create_log current_user.uuid, "Deactivated Supplier", @supplier
        elsif params[:supplier][:active] == "true"
          create_log current_user.uuid, "Activated Supplier", @supplier
        end

        if params[:supplier][:active] == "1" or params[:supplier][:status] == "0"
          create_log current_user.uuid, "Updated Supplier", @supplier  
        end
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
