class PlansController < ApplicationController
  before_filter :set_title
  load_and_authorize_resource except: :create
  
  add_breadcrumb "All Plans", :plans_path

  def index
    begin
      @plan = Plan.new

      if params[:plan] and params[:plan][:name] and !params[:plan][:name].nil?
        @plans = Plan.find_by_plan_name(params[:plan][:name]).page(params[:page]).per(5)
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
    wb.add_worksheet(name: "Multi Chart and Plan Data") do |sheet|
      heading = sheet.styles.add_style alignment: {horizontal: :center}, b: true, sz: 14, bg_color: "0066CC", fg_color: "FF"
      text_body = sheet.styles.add_style alignment: {horizontal: :left}, bg_color: "DCDCDC"
      sheet.add_row ["Name", "Quantity","Unit","Year"], style: heading
      @plans.each do |plan|
        sheet.add_row [plan.name, plan.quantity,plan.unit,plan.year], style: text_body
      end
    end

    send_data p.to_stream.read, type: "application/xlsx", filename: "Plans.xlsx" 

  end

  def new
    @plan = Plan.new
  end

  def create
    # begin
      @plan = Plan.new(plan_params)

      if @plan.save!
        flash[:notice] = "Plan saved successfully"
        puts "1111111111111111111111111111111111111"
        redirect_to plans_path
      else
        puts "22222222222222222222222222222222222222"
        flash[:notice] = "Plan can't save"
        redirect_to :back
      end
    # rescue Exception => e
    #   puts "333333333333333333333333333333333333333333333333333"
    #   puts e
    # end
  end

  def edit
    @plan = Plan.find(params[:id])
    add_breadcrumb @plan.name, :edit_plan_path
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
