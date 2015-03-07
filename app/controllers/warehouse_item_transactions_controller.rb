class WarehouseItemTransactionsController < ApplicationController
  # before_update :change_data_values
  load_and_authorize_resource except: :create
  respond_to :html, :json

  add_breadcrumb "All Warehouse Item Transactions", :warehouse_item_requested_transactions_path

  def index_item_requested
    begin
      @warehouse_item_requested_transaction = WarehouseItemTransaction.new

      if params[:warehouse_item_requested_transaction] and params[:warehouse_item_requested_transaction][:requested_date] and !params[:warehouse_item_requested_transaction][:requested_date].nil?
        @warehouse_item_requested_transactions = WarehouseItemTransaction.find_by_requested_number(params[:warehouse_item_requested_transaction][:requested_date]).page(params[:page]).per(session[:item_per_page])
      else
        @warehouse_item_requested_transactions = WarehouseItemTransaction.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def index_item_received
    begin
      @warehouse_item_received_transaction = WarehouseItemTransaction.new

      if params[:warehouse_item_received_transaction] and params[:warehouse_item_received_transaction][:received_date] and !params[:warehouse_item_received_transaction][:received_date].nil?
        @warehouse_item_received_transactions = WarehouseItemTransaction.find_by_requested_number(params[:warehouse_item_received_transaction][:received_date]).page(params[:page]).per(session[:item_per_page])
      else
        @warehouse_item_received_transactions = WarehouseItemTransaction.page(params[:page]).per(session[:item_per_page]).where(transaction_status: "Received")
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new
      
      @materials = Material.all

      @central_warehouse_type = WarehouseType.find-by_name("Central Warehouse") 
      @project_warehouse_type = WarehouseType.find-by_name("Project Warehouse") 

      @central_warehouses = Warehouse.find_by('(warehouse_type_uuid= ? AND active= ?)', central_warehouse_type.uuid, true)
      @project_warehouses = Warehouse.find_by('(warehouse_type_uuid= ? AND active= ?)', project_warehouse_type.uuid, true)

    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new(warehouse_item_transaction_params)

      if @warehouse_item_transaction.save!
        flash[:notice] = "Warehouse Item Transaction saved successfully"
        redirect_to warehouse_item_requested_transactions_path
      else
        flash[:notice] = "Warehouse Item Transaction can't be saved"
        redirect_to :back
        # render 'new'
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
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.find(params[:id])

      if @warehouse_item_transaction.update_attributes(warehouse_item_transaction_params)
        flash[:notice] = "Warehouse Item Transaction updated"
        redirect_to warehouse_item_requested_transactions_path
      else
        flash[:notice] = "Warehouse Item Transaction can't be updated"
        # redirect_to :back
        render 'edit'
      end
    rescue Exception => e
      puts e
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

  def change_data_values
    if @warehouse_item_transaction.transaction_status = "Requested"
      @warehouse_item_transaction.transaction_status = "Received"
    else
      @warehouse_item_transaction.transaction_status = "Requested"  
    end  
  end

  private
  def warehouse_item_transaction_params
    params.require(:warehouse_item_transaction).permit(:sender_id, :receiver_id, :material_id, :transaction_status, :requested_number, :created_by, :updated_by, :requested_date, :received_date, :due_date, :note, :amount)
  end
end
