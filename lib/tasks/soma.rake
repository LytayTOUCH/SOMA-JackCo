namespace :soma do
  desc "Re seed distribution data by adding read_only & function_name fields"
  task re_seed_distribution: :environment do
    unit = UnitOfMeasurement.find_by_name('Unit')
    kg = UnitOfMeasurement.find_by_name('Kg')
    coconut = PlantingProject.find_by_name('Coconut')
    jk = PlantingProject.find_by_name('Jackfruit')
    
    Distribution.delete_all
    [
      {read_only: 1, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000001', label: 'Total Production',         uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 1,  note: ''},
      {read_only: 1, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000002', label: 'Young Fruit',              uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 2,  note: ''},
      {read_only: 1, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000003', label: 'Good Young Fruit',         uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 3,  note: ''},
      {read_only: 0, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000004', label: 'Spoiled Young Fruit',      uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 4,  note: ''},
      {read_only: 1, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000005', label: 'Ripe Fruit',               uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 5,  note: ''},
      {read_only: 1, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000006', label: 'Good Ripe Fruit',          uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 6,  note: ''},
      {read_only: 0, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000007', label: 'Spoiled Ripe Fruit',       uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 7,  note: ''},
      {read_only: 0, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 1, uuid: '00000000-0000-0000-0000-000000000008', label: 'To Finish Good Warehouse', uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 8,  note: ''},
      {read_only: 0, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000009', label: 'Free at Farm',             uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 9,  note: ''},
      {read_only: 1, function_name: "coconutAutoCalc",   to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000010', label: 'Spoiled Waste',            uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 10, note: ''},
      {read_only: 0, function_name: "coconutAutoCalc",   to_nursery: 1, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000011', label: 'To Nursery Warehouse',     uoms: unit.uuid+'|'+unit.name,                             planting_project_id: coconut.uuid, order_of_display: 11, note: ''},
      
      {read_only: 1, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000012', label: 'Total Production',         uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 1,  note: ''},
      {read_only: 1, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000013', label: 'Ripe Fruit',               uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 2,  note: ''},
      {read_only: 0, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000014', label: 'Good Ripe Fruit',          uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 3,  note: ''},
      {read_only: 0, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000015', label: 'Damaged Ripe Fruit',       uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 4,  note: ''},
      {read_only: 0, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000016', label: 'Spoiled Ripe Fruit',       uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 5,  note: ''},
      {read_only: 0, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000017', label: 'Young Fruit',              uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 6,  note: ''},
      {read_only: 1, function_name: "jackfruitAutoCalc", to_nursery: 1, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000018', label: 'To Nursery Warehouse',     uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 7,  note: ''},
      {read_only: 0, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 1, uuid: '00000000-0000-0000-0000-000000000019', label: 'To Finish Good Warehouse', uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 8,  note: ''},
      {read_only: 1, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000020', label: 'Spoiled Waste',            uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 9,  note: ''}
    ].each do |d|
      Distribution.create_with(read_only: d[:read_only], function_name: d[:function_name], to_nursery: d[:to_nursery], to_finish: d[:to_finish], label: d[:label], uoms: d[:uoms], planting_project_id: d[:planting_project_id], order_of_display: d[:order_of_display], note: d[:note]).find_or_create_by(uuid: d[:uuid])
    end
  end
  
  desc "Update output_tasks table, and set new fields (nursery_warehouse_id, finish_warehouse_id) to default nursery & finish good warehouse"
  task update_output_task: :environment do
    nw = Warehouse.find_by_name("Coconut Nursery WH")
    fw = Warehouse.find_by_name("Oroung Finished Goods WH")
    
    OutputTask.all.each do |ot|
      ot.update_attributes(nursery_warehouse_id: nw.uuid, finish_warehouse_id: fw.uuid)
    end
  end
  
  desc "Seed initialize data into [app_descriptions] table"
  task seed_app_description: :environment do
    [
      {uuid: 'coconut0-app1-0000-0000-000000000001', app_id: 'coconut0-0000-0000-0000-00000000app1', name: 'All Zone'},
      {uuid: 'coconut0-app2-0000-0000-000000000002', app_id: 'coconut0-0000-0000-0000-00000000app2', name: 'Age : 1- 4 y'},
      {uuid: 'coconut0-app2-0000-0000-000000000003', app_id: 'coconut0-0000-0000-0000-00000000app2', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app3-0000-0000-000000000004', app_id: 'coconut0-0000-0000-0000-00000000app3', name: 'All Age'},
      {uuid: 'coconut0-app4-0000-0000-000000000005', app_id: 'coconut0-0000-0000-0000-00000000app4', name: 'Age : 3- 4 y, Flowering Trees'},
      {uuid: 'coconut0-app4-0000-0000-000000000006', app_id: 'coconut0-0000-0000-0000-00000000app4', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app5-0000-0000-000000000007', app_id: 'coconut0-0000-0000-0000-00000000app5', name: 'All Age'},
      {uuid: 'coconut0-app6-0000-0000-000000000008', app_id: 'coconut0-0000-0000-0000-00000000app6', name: 'All Zone'},
      {uuid: 'coconut0-app7-0000-0000-000000000009', app_id: 'coconut0-0000-0000-0000-00000000app7', name: 'All Zone'},
      {uuid: 'coconut0-app8-0000-0000-000000000010', app_id: 'coconut0-0000-0000-0000-00000000app8', name: 'Age : 1- 4 y'},
      {uuid: 'coconut0-app9-0000-0000-000000000011', app_id: 'coconut0-0000-0000-0000-00000000app9', name: 'All Zone'},
      {uuid: 'coconut0-app10-000-0000-000000000012', app_id: 'coconut0-0000-0000-0000-0000000app10', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app11-000-0000-000000000013', app_id: 'coconut0-0000-0000-0000-0000000app11', name: 'All Zone'},
      {uuid: 'coconut0-app12-000-0000-000000000014', app_id: 'coconut0-0000-0000-0000-0000000app12', name: 'All Zone'},
      {uuid: 'coconut0-app13-000-0000-000000000015', app_id: 'coconut0-0000-0000-0000-0000000app13', name: 'All Zone'},
      {uuid: 'coconut0-app14-000-0000-000000000016', app_id: 'coconut0-0000-0000-0000-0000000app14', name: 'Zone I + IV'},
      {uuid: 'coconut0-app15-000-0000-000000000017', app_id: 'coconut0-0000-0000-0000-0000000app15', name: 'Age : 1- 2 y'},
      {uuid: 'coconut0-app15-000-0000-000000000018', app_id: 'coconut0-0000-0000-0000-0000000app15', name: 'Age : 3- 4 y, Flowering Trees'},
      {uuid: 'coconut0-app15-000-0000-000000000019', app_id: 'coconut0-0000-0000-0000-0000000app15', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app16-000-0000-000000000020', app_id: 'coconut0-0000-0000-0000-0000000app16', name: 'Age : 1- 2 y'},
      {uuid: 'coconut0-app16-000-0000-000000000021', app_id: 'coconut0-0000-0000-0000-0000000app16', name: 'Age : 3- 4 y, Flowering Trees'},
      {uuid: 'coconut0-app16-000-0000-000000000022', app_id: 'coconut0-0000-0000-0000-0000000app16', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app17-000-0000-000000000023', app_id: 'coconut0-0000-0000-0000-0000000app17', name: 'Age : 1- 2 y'},
      {uuid: 'coconut0-app17-000-0000-000000000024', app_id: 'coconut0-0000-0000-0000-0000000app17', name: 'Age : 3- 4 y, Flowerig  Trees'},
      {uuid: 'coconut0-app18-000-0000-000000000025', app_id: 'coconut0-0000-0000-0000-0000000app18', name: 'Age : 1- 2 y (In Zone I)'},
      {uuid: 'coconut0-app18-000-0000-000000000026', app_id: 'coconut0-0000-0000-0000-0000000app18', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app19-000-0000-000000000027', app_id: 'coconut0-0000-0000-0000-0000000app19', name: 'Age : 3- 4 y, Flowerig  Trees'},
      {uuid: 'coconut0-app19-000-0000-000000000028', app_id: 'coconut0-0000-0000-0000-0000000app19', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app20-000-0000-000000000029', app_id: 'coconut0-0000-0000-0000-0000000app20', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app21-000-0000-000000000030', app_id: 'coconut0-0000-0000-0000-0000000app21', name: 'Age : 5- 15 y, Blossoming Trees'},
      {uuid: 'coconut0-app22-000-0000-000000000031', app_id: 'coconut0-0000-0000-0000-0000000app22', name: 'Zone I+ IV'},
      {uuid: 'coconut0-app23-000-0000-000000000032', app_id: 'coconut0-0000-0000-0000-0000000app23', name: 'All Zone'},
      {uuid: 'coconut0-app24-000-0000-000000000033', app_id: 'coconut0-0000-0000-0000-0000000app24', name: 'Zone V'},
      
      {uuid: 'jackfrui-app1-0000-0000-000000000001', app_id: 'jackfrui-0000-0000-0001-00000000app1', name: 'បណ្តុះគ្រាប់ខ្នុរ និង​លាយដី ជាមួយ​ផេះអង្កាម រួច​ច្រកថង់'},
      {uuid: 'jackfrui-app2-0000-0000-000000000002', app_id: 'jackfrui-0000-0000-0001-00000000app2', name: 'ផ្សាំមែក​ និងកាត់សំអាតមែក'},
      {uuid: 'jackfrui-app3-0000-0000-000000000003', app_id: 'jackfrui-0000-0000-0001-00000000app3', name: 'ប្រើអេស្ការ និង​កម្មករ'},
      {uuid: 'jackfrui-app4-0000-0000-000000000004', app_id: 'jackfrui-0000-0000-0001-00000000app4', name: 'បូមទឹកចូល និងចេញពីប្រឡាយមេ ទៅប្រឡាយខាងក្រៅ'},
      {uuid: 'jackfrui-app5-0000-0000-000000000005', app_id: 'jackfrui-0000-0000-0001-00000000app5', name: 'ប្រើធុង​ចំណុះ២០ល បាញ់ថ្នាំការពារត្រួយ និងផ្លែ  សំលាប់សត្វល្អិត និង​ ដាក់ថ្នាំសំលាប់ដូង'},
      {uuid: 'jackfrui-app6-0000-0000-000000000006', app_id: 'jackfrui-0000-0000-0001-00000000app6', name: 'ប្រើធុង​ចំណុះ២០ល &ឡនបាញ់ថ្នាំ'},
      {uuid: 'jackfrui-app7-0000-0000-000000000007', app_id: 'jackfrui-0000-0000-0001-00000000app7', name: 'កាប់ដោយ​ចបកាប់ ប្រើជីកំប៉ុស្តិ រឺ លាមកមាន់​ រឺ លាមកគោ'},
      {uuid: 'jackfrui-app8-0000-0000-000000000008', app_id: 'jackfrui-0000-0000-0001-00000000app8', name: 'កាប់ដោយ​ចបកាប់ ប្រើជីកំប៉ុស្តិ រឺ លាមកមាន់​ រឺ លាមកគោ'},
      {uuid: 'jackfrui-app9-0000-0000-000000000009', app_id: 'jackfrui-0000-0000-0001-00000000app9', name: 'កាប់ដោយ​ចបកាប់ ប្រើជីកំប៉ុស្តិ រឺ លាមកមាន់​ រឺ លាមកគោ'},
      {uuid: 'jackfrui-app10-000-0000-000000000010', app_id: 'jackfrui-0000-0000-0001-0000000app10', name: 'ប្រើបំប៉ន ដើម្បីឲ្យដើម ស្លឹក ផ្លែបានល្អ'},
      {uuid: 'jackfrui-app11-000-0000-000000000011', app_id: 'jackfrui-0000-0000-0001-0000000app11', name: 'ប្រើបំប៉ន ដើម្បីឲ្យដើម ស្លឹក ផ្លែបានល្អ'},
      {uuid: 'jackfrui-app12-000-0000-000000000012', app_id: 'jackfrui-0000-0000-0001-0000000app12', name: 'ប្រើការពារផ្លែខ្នុរប្រេះ'},
      {uuid: 'jackfrui-app13-000-0000-000000000013', app_id: 'jackfrui-0000-0000-0001-0000000app13', name: 'កាត់ក្តឹបតាមបច្ចេកទេស'},
      {uuid: 'jackfrui-app14-000-0000-000000000014', app_id: 'jackfrui-0000-0000-0001-0000000app14', name: 'កាត់ក្តឹបតាមបច្ចេកទេស'},
      {uuid: 'jackfrui-app15-000-0000-000000000015', app_id: 'jackfrui-0000-0000-0001-0000000app15', name: 'កម្មករ បេះផ្លែខ្នុរលក់'}
    ].each do |app|
      AppDescription.create_with(app_id: app[:app_id], name: app[:name]).find_or_create_by(uuid: app[:uuid])
    end
  end

  desc "Seed initialize data into [process_plan_categories] table"
  task seed_process_plan_category: :environment do
    [
      {uuid: 'process-plan-category-ip-1-000000001', name: 'IP-1'},
      {uuid: 'process-plan-category-ip-2-000000002', name: 'IP-2'},
      {uuid: 'process-plan-category-ip-3-000000003', name: 'IP-3'},
      {uuid: 'process-plan-category-ip-4-000000004', name: 'IP-4'},
      {uuid: 'process-plan-category-ip-5-000000005', name: 'IP-5'},
      {uuid: 'process-plan-category-ip-6-000000006', name: 'IP-6'},
      {uuid: 'process-plan-category-labor-00000007', name: 'LABOR'},
      {uuid: 'process-plan-category-machinery-0008', name: 'MACHINERY'},
      {uuid: 'process-plan-category-other-00000009', name: 'OTHER'}
    ].each do |p|
      ProcessPlanCategory.create_with(name: p[:name]).find_or_create_by(uuid: p[:uuid])
    end
  end
end
