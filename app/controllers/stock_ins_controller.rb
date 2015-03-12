class StockInsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Stock In", :stock_ins_path

  def index
    begin
      @stock_in = StockIn.new

      if params[:stock_in] and params[:stock_in][:name] and !params[:stock_in][:name].nil?
        @stock_ins = StockIn.find_by_stock_in_name(params[:stock_in][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @stock_ins = StockIn.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @stock_in = StockIn.new
      @warehouses = Warehouse.all
      @materials = Material.all
      @labors = Labor.all
    rescue Exception => e
      puts e
    end
  end

  def show
    @stock_in = StockIn.find(params[:id])
    add_breadcrumb @stock_in.name, :stock_in_path
  end

  def create
    begin
      @stock_in = StockIn.new(stock_in_params)

      if @stock_in.save
        flash[:notice] = "StockIn saved successfully"
        redirect_to stock_ins_path
      else
        flash[:notice] = "StockIn can't be saved"
        # redirect_to :back
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def stock_in_params
    params.require(:stock_in).permit(:warehouse_id, :labor_id, :material_id, :amount, :stock_in_date)
  end

end
