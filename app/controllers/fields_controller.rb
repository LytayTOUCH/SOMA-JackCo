class FieldsController < ApplicationController
  before_filter :set_title

  def index
    
  end

  def new
    @field = Field.new
  end

  def create
    begin
      @field = Field.new(field_params)

      if @field.save!
        flash[:notice] = "Field saved successfully"
        redirect_to :back
      else
        flash[:notice] = "Field can't save"
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
