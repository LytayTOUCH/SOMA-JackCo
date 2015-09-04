class PlanInputDescsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  def index
    if !params[:filter].nil? && params[:filter][:year]!=""
      @year = params[:filter][:year]
      @input_plan = InputDescPlan.find_by(year: @year, planting_project_id: params[:filter][:planting_project_id])
      @planting_project_name = PlantingProject.find(params[:filter][:planting_project_id]).name
    end
  end
  
  def new
    @year = params[:year]
    @planting_project_id = params[:planting_project_id]
    @planting_project_name = PlantingProject.find(@planting_project_id).name
    
    @fertilizers = Material.where(material_cate_uuid: MaterialCategory.find_by_name("Fertilizers").uuid)
    @pest_insecticides = Material.where(material_cate_uuid: MaterialCategory.find_by_name("Pest & Insecticides").uuid)
    @fungicides = Material.where(material_cate_uuid: MaterialCategory.find_by_name("Fungicides").uuid)
    @herbicides = Material.where(material_cate_uuid: MaterialCategory.find_by_name("Herbicides").uuid)
    @indirect_others = Material.where(material_cate_uuid: MaterialCategory.find_by_name("Indirect Materials").uuid, material_cate_uuid: MaterialCategory.find_by_name("Other").uuid)
  end
  
  def create
    @input_desc_plan = InputDescPlan.new(year: params[:year], planting_project_id: params[:planting_project_id])
    if @input_desc_plan.save
      create_log current_user.uuid, "Created New Input Description Plan", @input_desc_plan
      
      # Direct Material
      if params[:cd_direct_material].present?
        params[:cd_direct_material].each_with_index do |cd, index|
          InputDescPlanSeed.create(input_desc_plan_id: @input_desc_plan.uuid, no: index+1, cd: cd, udc: params[:udc_direct_material][index], ra: params[:ra_direct_material][index])
        end
      end
      
      fertilizer_id = MaterialCategory.find_by_name("Fertilizers").uuid
      chemical_id = MaterialSubCategory.find_by_name("Chemical Fertilizer").uuid
      natural_id = MaterialSubCategory.find_by_name("Natural Fertilizer").uuid
      # Chemical Fertilizer
      if params[:cd_chemical_fertilizer].present?
        params[:cd_chemical_fertilizer].each_with_index do |cd, index|
          InputDescPlanMaterial.create(input_desc_plan_id: @input_desc_plan.uuid,
                                       category_id: fertilizer_id,
                                       sub_category_id: chemical_id,
                                       no: index+1,
                                       material_label: params[:l_chemical_fertilizer][index],
                                       material_uom: params[:uom_chemical_fertilizer][index],
                                       cd: cd,
                                       udc: params[:udc_chemical_fertilizer][index],
                                       ra: params[:ra_chemical_fertilizer][index])
        end
      end
      
      # Natural Fertilizer
      if params[:cd_natural_fertilizer].present?
        params[:cd_natural_fertilizer].each_with_index do |cd, index|
          InputDescPlanMaterial.create(input_desc_plan_id: @input_desc_plan.uuid,
                                       category_id: fertilizer_id,
                                       sub_category_id: natural_id,
                                       no: index+1,
                                       material_label: params[:l_natural_fertilizer][index],
                                       material_uom: params[:uom_natural_fertilizer][index],
                                       cd: cd,
                                       udc: params[:udc_natural_fertilizer][index],
                                       ra: params[:ra_natural_fertilizer][index])
        end
      end
      
      pest_insect_id = MaterialCategory.find_by_name("Pest & Insecticides").uuid
      # Pest & Insecticides
      if params[:cd_pest_insecticides].present?
        params[:cd_pest_insecticides].each_with_index do |cd, index|
          InputDescPlanMaterial.create(input_desc_plan_id: @input_desc_plan.uuid,
                                       category_id: pest_insect_id,
                                       no: index+1,
                                       material_label: params[:l_pest_insecticides][index],
                                       material_uom: params[:uom_pest_insecticides][index],
                                       cd: cd,
                                       udc: params[:udc_pest_insecticides][index],
                                       ra: params[:ra_pest_insecticides][index])
        end
      end
      
      fungicide_id = MaterialCategory.find_by_name("Fungicides").uuid
      # Fungicides
      if params[:cd_fungicides].present?
        params[:cd_fungicides].each_with_index do |cd, index|
          InputDescPlanMaterial.create(input_desc_plan_id: @input_desc_plan.uuid,
                                       category_id: fungicide_id,
                                       no: index+1,
                                       material_label: params[:l_fungicides][index],
                                       material_uom: params[:uom_fungicides][index],
                                       cd: cd,
                                       udc: params[:udc_fungicides][index],
                                       ra: params[:ra_fungicides][index])
        end
      end
      
      herbicide_id = MaterialCategory.find_by_name("Herbicides").uuid
      # Herbicides
      if params[:cd_herbicides].present?
        params[:cd_herbicides].each_with_index do |cd, index|
          InputDescPlanMaterial.create(input_desc_plan_id: @input_desc_plan.uuid,
                                       category_id: herbicide_id,
                                       no: index+1,
                                       material_label: params[:l_herbicides][index],
                                       material_uom: params[:uom_herbicides][index],
                                       cd: cd,
                                       udc: params[:udc_herbicides][index],
                                       ra: params[:ra_herbicides][index])
        end
      end
      
      indirect_id = MaterialCategory.find_by_name("Indirect Materials").uuid
      # Indirect Materials
      if params[:cd_indirect_others].present?
        params[:cd_indirect_others].each_with_index do |cd, index|
          InputDescPlanMaterial.create(input_desc_plan_id: @input_desc_plan.uuid,
                                       category_id: indirect_id,
                                       no: index+1,
                                       material_label: params[:l_indirect_others][index],
                                       material_uom: params[:uom_indirect_others][index],
                                       cd: cd,
                                       udc: params[:udc_indirect_others][index],
                                       ra: params[:ra_indirect_others][index])
        end
      end
      
      other_id = MaterialCategory.find_by_name("Other").uuid
      # Other
      if params[:cd_other].present?
        params[:cd_other].each_with_index do |cd, index|
          InputDescPlanMaterial.create(input_desc_plan_id: @input_desc_plan.uuid,
                                       category_id: other_id,
                                       no: index+1,
                                       material_label: params[:l_other][index],
                                       material_uom: "",
                                       cd: cd,
                                       udc: params[:udc_other][index],
                                       ra: params[:ra_other][index])
        end
      end
      
      flash[:notice] = "Input Description Plan save successfully"
      redirect_to plan_input_descs_index_path+"?filter[year]="+params[:year]+"&filter[planting_project_id]="+params[:planting_project_id]
    else
      flash[:notice] = "Input Description Plan can't be saved."
      redirect_to plan_input_descs_new_path+"?year="+params[:year]+"&planting_project_id="+params[:planting_project_id]
    end
  end
end
