class WarehouseMaterialReceivedsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Receives", :warehouse_material_receiveds_path
  # redirect_to warehouse_material_receiveds_path, notice: "All Receives"

  def index
    begin
      @warehouse_item_transaction = WarehouseItemTransaction.new
      # @warehouse_material_received = WarehouseMaterialReceived.new

      if params[:warehouse_item_transaction] and params[:warehouse_item_transaction][:requested_number] and !params[:warehouse_item_transaction][:requested_number].nil?
        @warehouse_item_receive_transactions = WarehouseItemTransaction.find_by_requested_number(params[:warehouse_item_transaction][:requested_number]).page(params[:page]).per(4)
      else
        @warehouse_item_receive_transactions = WarehouseItemTransaction.where("transaction_status = ? OR transaction_status = ? OR transaction_status = ?", "Received", "Closed", "Partially Received").order("created_at desc").page(params[:page]).per(4)
      end

      # if params[:warehouse_material_received] and params[:warehouse_material_received][:requested_number] and !params[:warehouse_material_received][:requested_number].nil?
      #   @warehouse_material_receiveds = WarehouseMaterialReceived.find_by_requested_number(params[:warehouse_material_received][:requested_number]).select("DISTINCT(warehouse_item_transaction_id)").order("created_at desc").page(params[:page]).per(5)
      # else
        # @warehouse_material_receiveds = WarehouseMaterialReceived.select("DISTINCT(warehouse_item_transaction_id)").order("created_at desc").page(params[:page]).per(4)
      # end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @warehouse_material_received = WarehouseMaterialReceived.new
      @warehouse_item_transaction = WarehouseItemTransaction.find_by(uuid: params[:warehouse_item_requested_transaction_id])
      @warehouse_item_transaction_remaining_amount = @warehouse_item_transaction.remaining_amount
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @warehouse_material_received = WarehouseMaterialReceived.new(warehouse_material_received_params)

      # "============== Cutting Stock ============="  
      @warehouse_item_transaction = WarehouseItemTransaction.find_by(uuid: @warehouse_material_received.warehouse_item_transaction_id)
      
      @warehouse_central_material = WarehouseMaterialAmount.find_by(warehouse_uuid: @warehouse_item_transaction.sender_id, material_uuid: @warehouse_item_transaction.material_id)

      @warehouse_project_material = WarehouseMaterialAmount.find_by(warehouse_uuid: @warehouse_item_transaction.receiver_id, material_uuid: @warehouse_item_transaction.material_id)

      remaining_amount = @warehouse_item_transaction.remaining_amount # 2000
      received_amount = @warehouse_material_received.received_amount # 1000
      amount_in_hand = @warehouse_central_material.amount

      puts "============================******============================"
      puts "Amount in Main Stock"
      puts amount_in_hand
      puts "============================******============================"
      puts "Remaining Amount"
      puts remaining_amount
      puts "============================******============================"

      if amount_in_hand >= remaining_amount and remaining_amount >= received_amount
        remain_amount_central_stock = amount_in_hand - received_amount
        remain_amount_request_partial = remaining_amount - received_amount
        warehouse_project_material_amount = @warehouse_project_material.amount + received_amount
        
        if remain_amount_request_partial == 0
          status = "Received"
        elsif remain_amount_request_partial > 0
          status = "Partially Received"
        end  
        
        @warehouse_central_material.update_attributes!(amount: remain_amount_central_stock)

        @warehouse_project_material.update_attributes!(amount: warehouse_project_material_amount)

        @warehouse_item_transaction.update_attributes!(remaining_amount: remain_amount_request_partial, transaction_status: status)

        if @warehouse_material_received.save!
          create_log_2 current_user.uuid, "Receive Material Request", "Request: " + @warehouse_item_transaction.requested_number + "(" + @warehouse_material_received.received_amount.to_s + " / " + @warehouse_item_transaction.amount.to_s + ")"
             
          flash[:notice] = "Warehouse Material Received saved"
          redirect_to warehouse_item_requested_transactions_path
        else
          flash[:notice] = "Warehouse Material Received can't be saved"
          redirect_to :back
        end
      else
        flash[:notice] = "Requested quantity exceeds stock quantity or remaining quantity. Please import stock in first"  
        redirect_to :back
      end 
    rescue Exception => e
      puts e
    end
  end



  private
  def warehouse_material_received_params
    params.require(:warehouse_material_received).permit(:warehouse_item_transaction_id, :received_date, :received_amount, :created_by, :updated_by)
  end

end
