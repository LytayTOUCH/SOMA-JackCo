class ProductionListController < ApplicationController
  def index
    @year = params[:y]
  end
end
