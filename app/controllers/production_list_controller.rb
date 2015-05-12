class ProductionListController < ApplicationController
  authorize_resource :class => false
  
  def index
    @year = params[:y]
  end
end
