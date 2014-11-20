class MachineriesController < ApplicationController
  def index
    @tractors = Tractor.all
    @implements = Implement.all
  end
end
