class LaborsController < ApplicationController
  def index
    @labors = LaborDecorator.new(Labor.all)
  end

  def new
    @labor = Labor.new

    @projects = Project.all
    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
  end

  def create
    @labor = Labor.new(labor_params)

    if @labor.save!
      flash[:notice] = "Implement saved successfully"
      redirect_to labors_path
    else
      flash[:notice] = "Implement can't save"
      redirect_to :back
    end
  end

  def edit
    @labor = Labor.find(params[:id])
  end

  def projects
    projects = Project.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html
      format.json { render json: projects.map { |project| { id: project.id, text: project.name }}}
    end
  end

  def labors
    labors = Labor.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html
      format.json { render json: labors.map { |labor| { id: labor.id, text: labor.name }}}
    end
  end

  def show
    @labor = Labor.find(params[:id])
  end

  private
  def labor_params
    params.require(:labor).permit(:name, :position_uuid, :description, :active, :project_tokens, :subordinate_uuid)
  end
end
