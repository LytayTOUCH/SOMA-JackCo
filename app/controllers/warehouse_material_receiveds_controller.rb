class WarehouseMaterialReceivedsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Receives", :warehouse_material_receiveds_path

  def index
    begin
      @warehouse_material_received = WarehouseMaterialReceived.new

      if params[:warehouse_material_received] and params[:warehouse_material_received][:name] and !params[:warehouse_material_received][:name].nil?
        @warehouse_material_receiveds = WarehouseMaterialReceived.find_by_warehouse_material_received_name(params[:warehouse_material_received][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @warehouse_material_receiveds = WarehouseMaterialReceived.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      puts "===========================================================***"
      puts @warehouse_item_transaction = WarehouseItemTransaction.find_by(uuid: params[:id])
      puts "===========================================================***"
      @warehouse_item_transaction_remaining_amount = @warehouse_item_transaction.remaining_amount
      @warehouse_item_transaction_uuid = @warehouse_item_transaction.uuid
      add_breadcrumb @warehouse_material_received.received_date, :edit_warehouse_material_received_path
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @warehouse_material_received = Warehouse.find(params[:id])

      if @warehouse_material_received.update_attributes(warehouse_material_received_params)
        flash[:notice] = "Warehouse updated"
        redirect_to warehouses_path
      else
        flash[:notice] = "Warehouse can't be updated"
        # redirect_to :back
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

end
