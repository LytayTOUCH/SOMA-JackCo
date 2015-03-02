class WarehouseItemTransactionsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Warehouse Item Transactions", :warehouse_item_transactions_path

  def index
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new

      if params[:warehouse_item_transaction] and params[:warehouse_item_transaction][:name] and !params[:warehouse_item_transaction][:name].nil?
        @warehouse_item_transactions = WarehouseItemTransaction.find_by_warehouse_item_transaction_name(params[:warehouse_item_transaction][:name]).page(params[:page]).per(5)
      else
        @warehouse_item_transactions = WarehouseItemTransaction.page(params[:page]).per(5).where(transaction_status: "Requested")
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new
      @warehouses = Warehouse.all
      @materials = Material.all
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new(warehouse_item_transaction_params)

      if @warehouse_item_transaction.save
        flash[:notice] = "WarehouseItemTransaction saved successfully"
        redirect_to warehouse_item_transactions_path
      else
        flash[:notice] = "WarehouseItemTransaction can't be saved"
        # redirect_to :back
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.find(params[:id])
      add_breadcrumb @warehouse_item_transaction.name, :edit_warehouse_item_transaction_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.find(params[:id])

      if @warehouse_item_transaction.update_attributes(warehouse_item_transaction_params)
        flash[:notice] = "WarehouseItemTransaction updated"
        redirect_to warehouse_item_transactions_path
      else
        flash[:notice] = "WarehouseItemTransaction can't update"
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

  private
  def warehouse_item_transaction_params
    params.require(:warehouse_item_transaction).permit(:sender_id, :receiver_id, :material_id, :transaction_status, :requested_number, :created_by, :updated_by, :requested_date, :received_date, :due_date, :note)
  end
end
