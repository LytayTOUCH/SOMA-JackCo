class PlansController < ApplicationController
  before_filter :set_title
  load_and_authorize_resource except: :create
  
  def index
    begin
      @plan = Plan.new

      if params[:plan] and params[:plan][:name] and !params[:plan][:name].nil?
        @plans = Plan.find_by_name(params[:plan][:name]).page(params[:page]).per(5)
      else
        @plans = Plan.page(params[:page]).order('updated_at DESC').per(5)
        @plans_pdf = Plan.page(params[:page]).order('updated_at DESC')

      end
    rescue Exception => e
      puts e
    end
  end

  def downloadpdf
    @plans = Plan.order('updated_at DESC')
    # Load the html to convert to PDF
    html = render_to_string(:layout => false , :action => "downloadpdf", :formats => :html)
    # Create a new kit and define page size to be USE A4 Paper
    kit = PDFKit.new(html, :page_size => 'A4', :orientation => 'Landscape')
    # Save the html to a PDF file
    send_file kit.to_file("#{Rails.root}/public/plans.pdf")
  
  end

  def downloadexcel
    @plans = Plan.order('updated_at DESC')
    p = Axlsx::Package.new
    wb = p.workbook

    # Start Bar Chart
    # a = Plan.where(unit: "Kg").count
    # b = Plan.where(unit: "Liter").count
    # c = Plan.where(unit: "Piece").count
    # set = Plan.where(unit: "Set").count
    wb.add_worksheet(name: "Multi Chart and Plan Data") do |sheet|
      # sheet.add_row ["", "Result Analysis", "", "", "", ""], height: 30
      # sheet.add_row ["Unit Kg", "Unit Liter", "Unit Piece", "Unit Set"]
      # sheet.add_row [a, b, c, set]
      # sheet.add_chart(Axlsx::Bar3DChart, :start_at => "H2", :end_at => "O14", :bar_dir => :col) do |chart|
      #   chart.add_series :data => sheet["A3:D3"], :labels => sheet["A2:D2"], :title => sheet["B1"], colors: ["00FF00", "0066CC", "F00000", "F7FE2E"]
      # end
    # End Bar Chart

    # Start Pie Chart
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row ["", "Result Analysis"]
      # sheet.add_row ["Unit", "Value"], height: 30
      # a = Plan.where(unit: "Kg").count
      # b = Plan.where(unit: "Liter").count
      # c = Plan.where(unit: "Piece").count
      # d = Plan.where(unit: "Set").count
      # sheet.add_row ["Kg", a]
      # sheet.add_row ["Liter", b]
      # sheet.add_row ["Piece", c]
      # sheet.add_row ["Set", d]
      # # sheet.add_row ["Simple Pie Chart"]
      # sheet.add_chart(Axlsx::Pie3DChart, :start_at => [7,15], :end_at => "P27", :title => "Pie Chart") do |chart|
      #   chart.add_series :data => sheet["B16:B19"], :labels => sheet["A16:A19"], :colors => ['FF0000', '00FF00', '0000FF', 'FFFF00']
      #   chart.d_lbls.d_lbl_pos = :bestFit
      #   chart.d_lbls.show_percent = :true
      # end
    # End Pie Chart

      # Start to Get All Plan data
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      # sheet.add_row [""]
      heading = sheet.styles.add_style alignment: {horizontal: :center}, b: true, sz: 14, bg_color: "0066CC", fg_color: "FF"
      text_body = sheet.styles.add_style bg_color: "DCDCDC"
      sheet.add_row ["Name", "Quantity","Unit","Year"], style: heading
      @plans.each do |plan|
        sheet.add_row [plan.name, plan.quantity,plan.unit,plan.year], style: text_body
      end
      # End to Get All Plan data  

    end

    send_data p.to_stream.read, type: "application/xlsx", filename: "Plans.xlsx" 

  end

  def new
    @plan = Plan.new
  end

  def create
    begin
      @plan = Plan.new(plan_params)

      if @plan.save!
        flash[:notice] = "Plan saved successfully"
        redirect_to plans_path
      else
        flash[:notice] = "Plan can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    begin
      @plan = Plan.find(params[:id])

      if @plan.update_attributes!(plan_params)
        flash[:notice] = "Plan updated successfully"
        redirect_to plans_path
      else
        flash[:notice] = "Plan can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    if @plan.destroy!
      flash[:notice] = "Plan deleted successfully"
      redirect_to plans_path
    else
      flash[:notice] = "Plan can't delete"
      redirect_to :back
    end
  end

  private
  def set_title
    content_for :title, "Plan"
  end

  def plan_params
    params.require(:plan).permit(:name, :quantity, :unit, :year)
  end

end
