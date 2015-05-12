class WarehouseItemTransactionsController < ApplicationController
  load_and_authorize_resource except: :create
  respond_to :html, :json

  add_breadcrumb "All Warehouse Item Transactions", :warehouse_item_transactions_path

  def index
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new

      unless params[:requested_id].nil?
        @warehouse_item_transaction = WarehouseItemTransaction.find(params[:requested_id])
        @warehouse_item_transaction.update_attributes!(transaction_status: "Closed")
      end

      if params[:warehouse_item_transaction] and params[:warehouse_item_transaction][:requested_number] and !params[:warehouse_item_transaction][:requested_number].nil?
        @warehouse_item_transactions = WarehouseItemTransaction.find_by_requested_number(params[:warehouse_item_transaction][:requested_number]).page(params[:page]).per(7)
      else
        @warehouse_item_transactions = WarehouseItemTransaction.page(params[:page]).per(7).order("created_at desc")
      end

      puts "======================================================"
      puts params[:warehouse_item_transaction][:requested_number]
      puts "======================================================"
      
    rescue Exception => e
      puts e
    end
  end

  def index_item_received
    begin
      @warehouse_item_received_transaction = WarehouseItemTransaction.new

      if params[:warehouse_item_received_transaction] and params[:warehouse_item_received_transaction][:received_date] and !params[:warehouse_item_received_transaction][:received_date].nil?
        @warehouse_item_received_transactions = WarehouseItemTransaction.find_by_requested_number(params[:warehouse_item_received_transaction][:received_date]).page(params[:page]).per(5)
      else
        @warehouse_item_received_transactions = WarehouseItemTransaction.page(params[:page]).per(5).where(transaction_status: "Received")
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new
      
      @central_warehouse_type = WarehouseType.find_by_name("Central Warehouse") 
      @project_warehouse_type = WarehouseType.find_by_name("Project Warehouse")
      @fertilizer_warehouse_type = WarehouseType.find_by_name("Fertilizer Warehouse") 

      @central_project_fertilizer_warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", @central_warehouse_type.uuid, true, @project_warehouse_type.uuid, true, @fertilizer_warehouse_type.uuid, true)
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new(warehouse_item_transaction_params)

      @central_warehouse_type = WarehouseType.find_by_name("Central Warehouse") 
      @project_warehouse_type = WarehouseType.find_by_name("Project Warehouse")
      @fertilizer_warehouse_type = WarehouseType.find_by_name("Fertilizer Warehouse") 

      @central_project_fertilizer_warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", @central_warehouse_type.uuid, true, @project_warehouse_type.uuid, true, @fertilizer_warehouse_type.uuid, true)

      if @warehouse_item_transaction.save
        create_log_3 current_user.uuid, "Create New Material Request", @warehouse_item_transaction, [:uuid, :requested_number, :amount, :requested_date]
        
        @warehouse_item_transaction.remaining_amount = @warehouse_item_transaction.amount
        @warehouse_item_transaction.save
        flash[:notice] = "Warehouse Item Transaction saved successfully"
        redirect_to warehouse_item_transactions_path
      else
        flash[:notice] = "Warehouse Item Transaction can't be saved"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.find(params[:id])
      @warehouses = Warehouse.all
      @materials = Material.all
      add_breadcrumb @warehouse_item_transaction.name, :edit_warehouse_item_transaction_path
    rescue Exception => e
      puts e
    end
  end

  def update
    @warehouse_item_transaction.transaction_status = "Closed" 

    if @warehouse_item_transaction.update(warehouse_item_transaction_params)
      create_log_2 current_user.uuid, "Closed Material Request", "ID: "+@warehouse_item_transaction.uuid + ", Reason: " + @warehouse_item_transaction.reason_for_closing_transaction
      @warehouse_item_transaction
    end
  end

  def destroy
    @warehouse_item_transaction = WarehouseItemTransaction.find(params[:id])
    @warehouse_item_transaction.destroy

    respond_to do |format|
      format.html { redirect_to warehouse_item_transactions_path, :notice => 'WarehouseItemTransaction was successfully deleted.' }
      format.json { render json: @warehouse_item_transaction, status: :created, location: @warehouse_item_transaction }
    end
  end

  private
  def warehouse_item_transaction_params
    params.require(:warehouse_item_transaction).permit(:sender_id, :receiver_id, :material_id, :transaction_status, :requested_number, :created_by, :updated_by, :requested_date, :remaining_amount, :due_date, :note, :amount, :reason_for_closing_transaction)
  end
end
