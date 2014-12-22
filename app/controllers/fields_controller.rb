class FieldsController < ApplicationController
  before_filter :set_title

  private
  def set_title
    content_for :title, "Field"
  end
end
