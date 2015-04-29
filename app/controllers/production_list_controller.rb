class ProductionListController < ApplicationController
  def index
    # binding.pry
    @year = params[:year]
  end
end
