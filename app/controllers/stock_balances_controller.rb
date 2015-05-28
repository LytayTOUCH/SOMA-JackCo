class StockBalancesController < ApplicationController
  load_and_authorize_resource except: :create
  
  # BEGINNING BALANCE
  def index
    if !params[:month_year].nil?
      @categories = MaterialCategory.all
      @month_year = params[:month_year]
      @month = @month_year.split("-")[0].to_i
      @year = @month_year.split("-")[1].to_i
    end
    
    unless params[:filter].nil?
      @warehouse_id = params[:filter][:warehouse_id]
    end
  end
  
  # BEGINNING BALANCE
  def update
    month = params[:month].to_i
    year = params[:year].to_i
    warehouse_id = params[:warehouse_id]
    
    # SELECTED MONTH UNTIL CURRENT MONTH
    params[:material_id].each_with_index do |material_id, index|
      new_beginning_balance = params[:balance_value][index]
      
      start_month = month
      this_month = Date.today.month
      
      while start_month <= this_month do
        
        # STOCK BALANCE
        sb = StockBalance.find_by(:material_id => material_id, :warehouse_id => warehouse_id, :month => start_month, :year => year)
        
        if sb.nil?
          StockBalance.create(material_id: material_id,
                              warehouse_id: warehouse_id,
                              material_category_id: Material.find_by_uuid(material_id).material_cate_uuid,
                              month: start_month, year: year, stock_in: 0, stock_out: 0,
                              beginning_balance: new_beginning_balance,
                              ending_balance: new_beginning_balance)
        else
          stock_in = sb.stock_in
          stock_out = sb.stock_out
          ending_balance = sb.ending_balance
          adjusted_ending_balance = sb.adjusted_ending_balance
          
          new_ending_balance = new_beginning_balance.to_f + stock_in - stock_out
          
          unless adjusted_ending_balance.nil?
            diff_balance = adjusted_ending_balance - ending_balance
            new_adjusted_ending_balance = (new_beginning_balance.to_f + stock_in - stock_out) + diff_balance
            
            sb.update(beginning_balance: new_beginning_balance, ending_balance: new_ending_balance, adjusted_ending_balance: new_adjusted_ending_balance)
          else
            sb.update(beginning_balance: new_beginning_balance, ending_balance: new_ending_balance)
          end
        end
        
        # CURRENT MONTH ONLY
        if start_month == this_month
          # WAREHOUSE MATERIAL AMOUNT
          whm = WarehouseMaterialAmount.find_by(:warehouse_uuid => warehouse_id, :material_uuid => material_id)
          if whm.nil?
            WarehouseMaterialAmount.create(warehouse_uuid: warehouse_id, material_uuid: material_id, amount: new_beginning_balance)
          else
            unless sb.nil?
              stock_in = sb.stock_in
              stock_out = sb.stock_out
              ending_balance = sb.ending_balance
              new_ending_balance = new_beginning_balance.to_f + stock_in - stock_out
              
              whm.update(amount: new_ending_balance)
            else
              whm.update(amount: new_beginning_balance)
            end
          end
        end
        
        start_month += 1
      end
    end
    
    flash[:notice] = "Stock Balance successfully initialized!!!"
    redirect_to stock_balances_path+"?month_year="+params[:month]+"-"+params[:year]+"&filter[warehouse_id]="+params[:warehouse_id]
  end
  
  # ADJUST BALANCE
  def adjust_form
    if !params[:month_year].nil?
      @categories = MaterialCategory.all
      @month_year = params[:month_year]
      @month = @month_year.split("-")[0].to_i
      @year = @month_year.split("-")[1].to_i
    end
    
    unless params[:filter].nil?
      @warehouse_id = params[:filter][:warehouse_id]
    end
  end
  
  # ADJUST BALANCE
  def update_adjust_balance
    month = params[:month].to_i
    year = params[:year].to_i
    warehouse_id = params[:warehouse_id]
    
    later_month = month + 1 > 12 ? 1 : month + 1
    later_year = month + 1 > 12 ? year + 1 : year
    
    # SELECTED MONTH & NEXT MONTH
    params[:material_id].each_with_index do |material_id, index|
      adjusted_balance = params[:balance_value][index]
      
      # SELECTED MONTH
      sb = StockBalance.find_by(:material_id => material_id, :warehouse_id => warehouse_id, :month => month, :year => year)
      if !sb.nil? && adjusted_balance != 0
        sb.update(adjusted_ending_balance: adjusted_balance, adjusted_note: params[:note][index]) 
      end
      
      # NEXT MONTH
      sb = StockBalance.find_by(:material_id => material_id, :warehouse_id => warehouse_id, :month => later_month, :year => later_year)
      if sb.nil? && adjusted_balance != 0
        StockBalance.create(material_id: material_id,
                            warehouse_id: warehouse_id,
                            material_category_id: Material.find_by_uuid(material_id).material_cate_uuid,
                            month: month+1, year: year, stock_in: 0, stock_out: 0,
                            beginning_balance: adjusted_balance,
                            ending_balance: adjusted_balance)
      elsif adjusted_balance != 0
        stock_in = sb.stock_in
        stock_out = sb.stock_out
        beginning_balance = adjusted_balance
        ending_balance = adjusted_balance.to_f + stock_in - stock_out
        
        sb.update(beginning_balance: beginning_balance, ending_balance: ending_balance)
      end
    end
    
    flash[:notice] = "Stock Balance successfully adjusted!!!"
    redirect_to adjust_stock_balance_path+"?month_year="+params[:month]+"-"+params[:year]+"&filter[warehouse_id]="+params[:warehouse_id]
  end
  
  # INVENTORY REPORT
  def report_inventory
    if !params[:month_year].nil?
      @materials = Material.order(:name)
      @month_year = params[:month_year]
      @month = @month_year.split("-")[0].to_i
      @year = @month_year.split("-")[1].to_i
    end
    
    unless params[:filter].nil?
      @warehouse_id = params[:filter][:warehouse_id]
    end
  end
end
