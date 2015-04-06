class WarehouseTypesController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Warehouse Types", :warehouse_types_path
  
  def index
    begin
      @warehouse_type = WarehouseType.new

      if params[:warehouse_type] and params[:warehouse_type][:name] and !params[:warehouse_type][:name].nil?
        @warehouse_types = WarehouseType.find_by_warehouse_type_name(params[:warehouse_type][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @warehouse_types = WarehouseType.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end
end
