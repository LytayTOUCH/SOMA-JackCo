class WarehouseItemTransactionsController < ApplicationController
  load_and_authorize_resource except: :create
  respond_to :html, :json

  add_breadcrumb "All Warehouse Item Transactions", :warehouse_item_requested_transactions_path

  def index_item_requested
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new

      unless params[:requested_id].nil?
        @warehouse_item_transaction = WarehouseItemTransaction.find(params[:requested_id])
        @warehouse_item_transaction.update_attributes!(transaction_status: "Closed")
      end

      if params[:warehouse_item_transaction] and params[:warehouse_item_transaction][:requested_number] and !params[:warehouse_item_transaction][:requested_number].nil?
        @warehouse_item_requested_transactions = WarehouseItemTransaction.find_by_requested_number(params[:warehouse_item_transaction][:requested_number]).page(params[:page]).per(7)
      else
        @warehouse_item_requested_transactions = WarehouseItemTransaction.page(params[:page]).per(7).order("created_at desc")
      end
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
      
      @materials = Material.all

      @central_warehouse_type = WarehouseType.find_by_name("Central Warehouse") 
      @project_warehouse_type = WarehouseType.find_by_name("Project Warehouse")
      @fertilizer_warehouse_type = WarehouseType.find_by_name("Fertilizer Warehouse") 

      @central_project_fertilizer_warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", @central_warehouse_type.uuid, true, @project_warehouse_type.uuid, true, @fertilizer_warehouse_type, true)
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new(warehouse_item_transaction_params)

      if @warehouse_item_transaction.save!
        @warehouse_item_transaction.remaining_amount = @warehouse_item_transaction.amount
        @warehouse_item_transaction.save
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

      # "============== Cutting Stock ============="  
      # @warehouse_central_material = WarehouseMaterialAmount.find_by(warehouse_uuid: @warehouse_item_transaction.sender_id, material_uuid: @warehouse_item_transaction.material_id)

      # @warehouse_project_material = WarehouseMaterialAmount.find_by(warehouse_uuid: @warehouse_item_transaction.receiver_id, material_uuid: @warehouse_item_transaction.material_id)      

      # requested_amount = @warehouse_item_transaction.amount # 2000
      # amount_in_hand = @warehouse_central_material.amount # 5000
      
      if @warehouse_item_transaction.update_attributes!(warehouse_item_transaction_params)

        # if amount_in_hand >= requested_amount
        #   remain_amount = amount_in_hand - requested_amount
        #   @warehouse_central_material.amount = remain_amount
        #   @warehouse_project_material.amount = @warehouse_project_material.amount + requested_amount
          
        #   @warehouse_central_material.update_attributes!(warehouse_uuid: @warehouse_item_transaction.sender_id, material_uuid: @warehouse_item_transaction.material_id, amount: remain_amount)

        #   @warehouse_project_material.update_attributes!(warehouse_uuid: @warehouse_item_transaction.receiver_id, material_uuid: @warehouse_item_transaction.material_id, amount: @warehouse_project_material.amount)
        # else
        #   flash[:notice] = "Can not update Stock"
        #   redirect_to :back
        # end  

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

  private
  def warehouse_item_transaction_params
    params.require(:warehouse_item_transaction).permit(:sender_id, :receiver_id, :material_id, :transaction_status, :requested_number, :created_by, :updated_by, :requested_date, :remaining_amount, :due_date, :note, :amount)
  end
end
