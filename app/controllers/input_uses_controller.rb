class InputUsesController < ApplicationController
  has_scope :start_date, :using => [:started_at, :ended_at] , :type => :hash

  def index
    @input_tasks = apply_scopes(InputTask).all

    @material_category = MaterialCategory.all

    @blocks = Block.group(:area)

  end

  def downloadpdf
    @input_tasks = apply_scopes(InputTask).all

    @material_category = MaterialCategory.all

    # Load the html to convert to PDF
    html = render_to_string(:layout => false , :action => "downloadpdf", :formats => :html)
    # Create a new kit and define page size to be USE A4 Paper
    kit = PDFKit.new(html, :page_size => 'A4', :orientation => 'Landscape')

    # kit.stylesheets << Rails.application.assets.find_asset('application.css.scss').to_s.html_safe
    # kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/application.css.scss"
    kit.stylesheets << "#{Rails.root}/public/styles.css.scss"
    # Save the html to a PDF file
    send_file kit.to_file("#{Rails.root}/public/input_uses_report.pdf")

  end

end