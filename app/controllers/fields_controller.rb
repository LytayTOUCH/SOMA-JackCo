class FieldsController < ApplicationController
  before_filter :set_title

  def index
  end

  def fields
    begin
      @fields = Field.all
      
      respond_to do |format|
        format.html
        format.json { render json: @fields }
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @field = Field.new
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @field = Field.new(field_params)

      if @field.save!
        flash[:notice] = "Field saved successfully"
        redirect_to fields_path
      else
        flash[:notice] = "Field can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @field = Field.find(params[:id])
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @field = Field.find(params[:id])

      if @field.update_attributes!(field_params)
        flash[:notice] = "Field updated successfully"
        redirect_to fields_path
      else
        flash[:notice] = "Field can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def set_title
    content_for :title, "Field"
  end

  def field_params
    params.require(:field).permit(:name, :dimension, :note, :lat_long)
  end
end
