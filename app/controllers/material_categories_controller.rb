class MaterialCategoriesController < ApplicationController
  def index
    begin
      @material_category = MaterialCategory.new

      if params[:material_category] and params[:material_category][:name] and !params[:material_category][:name].nil?
        @material_categories = MaterialCategory.find_by_material_type_name(params[:material_category][:name]).page(params[:page]).per(5)
      else
        @material_categories = MaterialCategory.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

end
