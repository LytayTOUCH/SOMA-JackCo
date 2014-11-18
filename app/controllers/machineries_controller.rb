class MachineriesController < ApplicationController
  def index
    @tractors = Tractor.all
  end
end
