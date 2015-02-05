class DashboardsController < ApplicationController
  respond_to :html, :json
  def index

    # data = [['1997',10],['1998',20],['1999',40]]

    @labels = TestingChart.pluck(:name, :amount)
    
    respond_with do |format|
      format.json {render :json => @labels}
    end

    # @line_chart = Gchart.pie(data: [60,30,50], title: 'Line chart', labels: @labels, size: '400x300')

    # data1 = [20, 60, 30]

    # @bar_chart = Gchart.bar(data: data1, bar_width_and_spacing: '35,20', title: 'Bar chart', labels: ["January", "Feburary", "March"], legend: ['courbe 1','courbe 2','courbe 3'], axis_with_label: ['J', 'F', 'M'], width: '500')
  end

  def downloadpdf
    # @labels = TestingChart.pluck(:name, :amount)
    
    # respond_with do |format|
    #   format.json {render :json => @labels}
    # end    

    # Load the html to convert to PDF
    html = render_to_string(:layout => false , :action => "downloadpdf", :formats => :html)
    # Create a new kit and define page size to be USE A4 Paper
    kit = PDFKit.new(html, :page_size => 'A4', :orientation => 'Landscape')
    # Save the html to a PDF file
    send_file kit.to_file("#{Rails.root}/public/dashboard_graph.pdf")
  
  end

  def downloadexcel
    @data_chart = TestingChart.all
    p = Axlsx::Package.new
    wb = p.workbook
      
    wb.add_worksheet(:name => "Pie Chart and Bar Chart") do |sheet|
       # Start Pie Chart
      title = sheet.styles.add_style alignment: {horizontal: :right}
      heading = sheet.styles.add_style alignment: {horizontal: :center}, b: true, sz: 14, bg_color: "0066CC", fg_color: "FF"
      text_body = sheet.styles.add_style bg_color: "DCDCDC"
      sheet.add_row ["", "Result Analysis"], height: 30, style: title
      sheet.add_row ["Name", "Amount"], style: heading
      @data_chart.each do |d|
        sheet.add_row [d.name, d.amount], style: text_body
      end
      sheet.add_chart(Axlsx::Pie3DChart, :start_at => "H3", :end_at => "N14", :title => "Pie Chart") do |chart|
        chart.add_series :data => sheet["B3:B6"], :labels => sheet["A3:A6"], :colors => ['0000FF', 'FF0000', 'FFA500', '008000']
        chart.d_lbls.d_lbl_pos = :bestFit
        chart.d_lbls.show_percent = :true
      end
    # End Pie Chart

    # Start Bar Chart
      sheet.add_row [""]
      sheet.add_row [""]
      sheet.add_row [""]
      sheet.add_row [""]
      sheet.add_row [""]
      sheet.add_row [""]
      sheet.add_row [""]
      sheet.add_row [""]
      sheet.add_row [""]
      sheet.add_row ["", "Result Analysis", "", "", "", ""], height: 30
      sheet.add_row ["Copper", "Silver", "Gold", "Platinum"], style: heading
      sheet.add_row [8.94, 40.49, 19.30, 31.45], style: text_body
      sheet.add_chart(Axlsx::Bar3DChart, :start_at => "H17", :end_at => "N29", :title => "Bar Chart", :bar_dir => :col) do |chart|
        chart.add_series :data => sheet["A18:D18"], :labels => sheet["A17:D17"], :title => sheet["B16"], colors: ["FF0000", "C0C0C0", "FFD700", "0000FF"]
        chart.d_lbls.show_val = true
      end
      # End Bar Chart
    end

      send_data p.to_stream.read, type: "application/xlsx", filename: "dashboardGraph.xlsx" 
    
  end
    

end