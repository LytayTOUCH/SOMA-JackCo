class DashboardsController < ApplicationController
  respond_to :html, :json

  has_scope :farm_id

  def index
    @farms=Farm.all
    @blocks_scope = apply_scopes(Block).all

    @planting_project_ids = @blocks_scope.select(:planting_project_id).uniq

    @farm=Farm.new

    @foos = Array.new

    @planting_project_ids.each do |p|
      project_name = PlantingProject.find_by_uuid(p.planting_project_id).project_name
      surface = @blocks_scope.where("planting_project_id=?", p.planting_project_id).sum(:surface)
      tree = @blocks_scope.where("planting_project_id=?", p.planting_project_id).sum(:tree_amount)

      f = Foo.new(project_name, surface, tree)
      @foos.push(f)
    end


    data = [['1997',10],['1998',20],['1999',40]]

    @labels = TestingChart.pluck(:name, :amount)
    
    respond_with do |format|
      format.json {render :json => @labels}
    end

    @line_chart = Gchart.pie(data: [60,30,50], title: 'Line chart', labels: @labels, size: '400x300')

    data1 = [20, 60, 30]

    @bar_chart = Gchart.bar(data: data1, bar_width_and_spacing: '35,20', title: 'Bar chart', labels: ["January", "Feburary", "March"], legend: ['courbe 1','courbe 2','courbe 3'], axis_with_label: ['J', 'F', 'M'], width: '500')
  end

  def getBarData
    @bar_chart_data = TestingWithBarChart.pluck(:element, :amount, :bar_color)
    respond_with do |format|
      format.json {render :json => @bar_chart_data}
    end            
  end
  
  def getPieData
    @pie_chart_data = TestingChart.pluck(:name, :amount)
    respond_with do |format|
      format.json {render :json => @pie_chart_data}
    end
  end

  def downloadpdf
    # Load the html to convert to PDF
    html = render_to_string(:layout => false , :action => "downloadpdf", :formats => :html)
    # Create a new kit and define page size to be USE A4 Paper
    kit = PDFKit.new(html, :page_size => 'A4', :orientation => 'Landscape')
    # Save the html to a PDF file
    send_file kit.to_file("#{Rails.root}/public/dashboard_graph.pdf")
  
  end

  def download_piechart_excel
    @data_piechart = TestingChart.all
    p = Axlsx::Package.new
    wb = p.workbook
      
    wb.add_worksheet(:name => "Pie Chart and Bar Chart") do |sheet|
       # Start Pie Chart
      heading = sheet.styles.add_style alignment: {horizontal: :center}, b: true, sz: 14, bg_color: "0066CC", fg_color: "FF"
      text_body = sheet.styles.add_style alignment: {horizontal: :left}, bg_color: "DCDCDC"
      sheet.add_row [""]
      sheet.add_row ["Name", "Amount"], style: heading
      @data_piechart.each do |d|
        sheet.add_row [d.name, d.amount], style: text_body
      end
      sheet.add_chart(Axlsx::Pie3DChart, :start_at => "H3", :end_at => "N14", :title => "Pie Chart") do |chart|
        chart.add_series :data => sheet["B3:B6"], :labels => sheet["A3:A6"], :colors => ['0000FF', 'FF0000', 'FFA500', '008000', 'FFC0CB', 'FFFF00', '808080', '800080', 'FFD700', '00FF00', '808000', '00FFFF']
        chart.d_lbls.d_lbl_pos = :bestFit
        chart.d_lbls.show_percent = :true
      end
    # End Pie Chart
    end

      send_data p.to_stream.read, type: "application/xlsx", filename: "dashboardGraph.xlsx" 
    
  end

  def download_barchart_excel
    @data_barchart = TestingWithBarChart.all
    p = Axlsx::Package.new
    wb = p.workbook
      
    wb.add_worksheet(:name => "Pie Chart and Bar Chart") do |sheet|
    # Start Bar Chart
      heading = sheet.styles.add_style alignment: {horizontal: :center}, b: true, sz: 14, bg_color: "0066CC", fg_color: "FF"
      text_body = sheet.styles.add_style alignment: {horizontal: :left}, bg_color: "DCDCDC"
      sheet.add_row [""]
      sheet.add_row ["Element", "Amount", "Bar Color"], style: heading
      @data_barchart.each do |d|
        sheet.add_row [d.element, d.amount, d.bar_color], style: text_body
      end
      sheet.add_chart(Axlsx::Bar3DChart, :start_at => "H3", :end_at => "N16", :title => "Bar Chart", :bar_dir => :col) do |chart|
        chart.add_series :data => sheet["B3:B6"], :labels => sheet["A3:A6"], colors: ["C0C0C0", "FFD700", "0000FF", "008000"]
        chart.d_lbls.show_val = true
      end
      # End Bar Chart
    end

      send_data p.to_stream.read, type: "application/xlsx", filename: "dashboardGraph.xlsx" 
    
  end

end