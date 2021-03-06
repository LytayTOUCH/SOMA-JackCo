class MaterialCategoriesController < ApplicationController
  add_breadcrumb "All Material Categories", :material_categories_path
  def index
    begin
      @material_category = MaterialCategory.new

      if params[:material_category] and params[:material_category][:name] and !params[:material_category][:name].nil?
        @material_categories = MaterialCategory.find_by_material_type_name(params[:material_category][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @material_categories = MaterialCategory.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

end
