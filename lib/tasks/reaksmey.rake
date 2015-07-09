namespace :reaksmey do
  desc "Start re_seed_distribution"
  
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
      {read_only: 0, function_name: "jackfruitAutoCalc", to_nursery: 1, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000018', label: 'To Nursery Warehouse',     uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 7,  note: ''},
      {read_only: 0, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 1, uuid: '00000000-0000-0000-0000-000000000019', label: 'To Finish Good Warehouse', uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 8,  note: ''},
      {read_only: 1, function_name: "jackfruitAutoCalc", to_nursery: 0, to_finish: 0, uuid: '00000000-0000-0000-0000-000000000020', label: 'Spoiled Waste',            uoms: unit.uuid+'|'+unit.name + ',' + kg.uuid+'|'+kg.name, planting_project_id: jk.uuid,      order_of_display: 9,  note: ''}
    ].each do |d|
      Distribution.create_with(read_only: d[:read_only], function_name: d[:function_name], to_nursery: d[:to_nursery], to_finish: d[:to_finish], label: d[:label], uoms: d[:uoms], planting_project_id: d[:planting_project_id], order_of_display: d[:order_of_display], note: d[:note]).find_or_create_by(uuid: d[:uuid])
    end
  end
end
