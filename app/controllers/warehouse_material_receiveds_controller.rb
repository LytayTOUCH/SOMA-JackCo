class WarehouseMaterialReceivedsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Receives", :warehouse_item_requested_transactions_path

  def index
    begin
      @warehouse_material_receiveds = WarehouseMaterialReceived.all.select("DISTINCT(warehouse_item_transaction_id)")
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

      if @warehouse_material_received.save!   
        # "============== Cutting Stock ============="  
        @warehouse_item_transaction = WarehouseItemTransaction.find_by(uuid: @warehouse_material_received.warehouse_item_transaction_id)
        
        @warehouse_central_material = WarehouseMaterialAmount.find_by(warehouse_uuid: @warehouse_item_transaction.sender_id, material_uuid: @warehouse_item_transaction.material_id)

        @warehouse_project_material = WarehouseMaterialAmount.find_by(warehouse_uuid: @warehouse_item_transaction.receiver_id, material_uuid: @warehouse_item_transaction.material_id)

        remaining_amount = @warehouse_item_transaction.remaining_amount # 2000
        received_amount = @warehouse_material_received.received_amount # 1000
        puts "============================******============================"
        puts amount_in_hand = @warehouse_central_material.amount
        puts "============================******============================"

        if amount_in_hand >= remaining_amount
          if remaining_amount >= received_amount
            remain_amount_central_stock = amount_in_hand - received_amount
            remain_amount_request_partial = remaining_amount - received_amount
            puts "============================******============================"
            puts @warehouse_central_material.amount = remain_amount_central_stock
            puts "============================******============================"
            warehouse_project_material_amount = @warehouse_project_material.amount + received_amount
            
            if remain_amount_request_partial == 0
              status = "Received"
            elsif remain_amount_request_partial > 0
              status = "Partially Received"
            end  
            
            @warehouse_central_material.update_attributes!(amount: remain_amount_central_stock)

            @warehouse_project_material.update_attributes!(amount: warehouse_project_material_amount)

            @warehouse_item_transaction.update_attributes!(remaining_amount: remain_amount_request_partial, transaction_status: status)
          end  
        else
          flash[:notice] = "Requested quantity exceeds stock quantity"    
        end  

        flash[:notice] = "Warehouse Material Received saved"
        redirect_to warehouse_item_requested_transactions_path
      else
        flash[:notice] = "Warehouse Material Received can't be saved"
        # redirect_to :back
        render 'edit'
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
