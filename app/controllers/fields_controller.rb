class FieldsController < ApplicationController
  load_and_authorize_resource except: :create
  before_filter :set_title
  respond_to :html, :js

  add_breadcrumb "All fields", :fields_path

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
      @field.lat_long = JSON.parse(field_params["lat_long"])

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
      @field.lat_long = @field.lat_long.to_json
      add_breadcrumb @field.name, :edit_field_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @field = Field.find(params[:id])
      temp_field_params = field_params
      temp_field_params[:lat_long] = JSON.parse(field_params["lat_long"])

      if @field.update_attributes!(temp_field_params)
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
    content_for :title, "Fields"
  end

  def field_params
    params.require(:field).permit(:name, :dimension, :note, :lat_long)
  end
end
