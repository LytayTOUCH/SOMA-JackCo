class StockInsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Stock In", :stock_ins_path

  def index
    @stock_in = StockIn.new
    @stock_ins = StockIn.order(stock_in_date: :desc)
  end

  def new
    @stock_in = StockIn.new
  end

  def show
    @stock_in = StockIn.find(params[:id])
    add_breadcrumb @stock_in.name, :stock_in_path
  end

  def create
    begin
      @stock_in = StockIn.new(stock_in_params)

      if @stock_in.save
        create_log current_user.uuid, "Created New Stock In", @stock_in
        
        # WAREHOUSE MATERIAL AMOUNT
        @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: @stock_in.warehouse.uuid, material_uuid: @stock_in.material.uuid)
        stock_in_amount = @stock_in.amount
        total_amount = @warehouse_material_amount.amount + stock_in_amount
        @warehouse_material_amount.update_attributes(warehouse_uuid: @stock_in.warehouse.uuid, material_uuid: @stock_in.material.uuid, amount: total_amount)

        # STOCK BALANCE
        month = @stock_in.stock_in_date.month
        year = @stock_in.stock_in_date.year
        material_id = @stock_in.material.uuid
        warehouse_id = @stock_in.warehouse.uuid
        
        sb = StockBalance.find_by(:material_id => material_id, :warehouse_id => warehouse_id, :month => month, :year => year)
        unless sb.nil?
          stock_in = sb.stock_in + @stock_in.amount
          ending_balance = sb.beginning_balance + stock_in - sb.stock_out
          
          unless sb.adjusted_ending_balance.nil?
            diff_balance = sb.adjusted_ending_balance - sb.ending_balance
            new_adjusted_ending_balance = ending_balance + diff_balance
            
            sb.update(stock_in: stock_in, ending_balance: ending_balance, adjusted_ending_balance: new_adjusted_ending_balance)
          else
            sb.update(stock_in: stock_in, ending_balance: ending_balance)
          end
        end
        
        flash[:notice] = "Stock In saved successfully"
        redirect_to stock_ins_path
      else
        flash[:notice] = "Stock In can't be saved."
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def stock_in_params
    params.require(:stock_in).permit(:warehouse_id, :labor_id, :material_id, :amount, :stock_in_date, :reference_number, :item_desc, :note)
  end

end
