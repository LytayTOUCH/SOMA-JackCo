class LaborsController < ApplicationController
  def index
    @labors = LaborDecorator.new(Labor.page(params[:page]).per(5))
  end

  def new
    begin
      @labor = Labor.new

      @projects = Project.all
      respond_to do |format|
        format.html
        format.json { render json: @projects }
      end
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @labor = Labor.new(labor_params)

      if @labor.save!
        flash[:notice] = "Implement saved successfully"
        redirect_to :back
      else
        flash[:notice] = "Implement can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @labor = Labor.find(params[:id])
  end

  def projects
    begin
      projects = Project.where("name like ?", "%#{params[:q]}%")

      respond_to do |format|
        format.html
        format.json { render json: projects.map { |project| { id: project.id, text: project.name }}}
      end
    rescue Exception => e
      puts e
    end
  end

  def labors
    begin
      labors = Labor.where("name like ?", "%#{params[:q]}%")

      respond_to do |format|
        format.html
        format.json { render json: labors.map { |labor| { id: labor.id, text: labor.name }}}
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def labor_params
    params.require(:labor).permit(:name, :position_uuid, :description, :active, :project_tokens, :subordinate_uuid)
  end
end
