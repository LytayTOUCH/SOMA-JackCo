class InputUsesController < ApplicationController
  authorize_resource :class => false
  has_scope :start_date, :using => [:started_at, :ended_at] , :type => :hash

  def index
  end
end