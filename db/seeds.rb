# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# run:
# rake db:seed

[
  {name: 'Oroung Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.333019, 104.864575'},
  {name: 'Chamkar Doung Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.341900, 104.822941'},
  {name: 'Otarath Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.336964, 104.830418'},
  {name: 'Kapaet Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.336681, 104.858414'}
].each do |farm|
  Farm.create_with(location: farm[:location], latlong_farm: farm[:latlong_farm]).find_or_create_by(name: farm[:name])
end

coconut_farm = Farm.find_by_name('Chamkar Doung Farm')
[
  {name: 'Block A1', surface: 4, shape_lat_long: '[[11.34228844248775,104.8173368444448],[11.34222380000888,104.8171604557845],[11.3419655618982,104.8170819933822],[11.34197186349495,104.8169376349896],[11.34152765634626,104.8168564506022],[11.34152565378016,104.8161860309814],[11.34072187781601,104.8161618977276],[11.34073587728222,104.8166945670797],[11.34083425409179,104.8171092601984],[11.34104359934694,104.8174874094787],[11.34114577172203,104.8181746246259],[11.34214745471061,104.8184887833901],[11.34225258745473,104.8181561580298],[11.34287072363673,104.8182904066128],[11.34309297859914,104.8175375089032],[11.34228844248775,104.8173368444448]]', location_lat_long: '[11.341644,104.817429]', rental_status: 0, status: 0, planting_project_id: 1, farm_id: coconut_farm.uuid, tree_amount: 150},
  {name: 'Block A2', surface: 4, shape_lat_long: '[[11.34120932973546,104.8183803286982],[11.34112138334435,104.8184150176988],[11.34092905012725,104.8183922652106],[11.34081065229375,104.8186381489472],[11.34173900706889,104.8191704886344],[11.34189976470813,104.8186003149401],[11.34120932973546,104.8183803286982]]', location_lat_long: '[11.341650,104.818817]', rental_status: 0, status: 0, planting_project_id: 1, farm_id: coconut_farm.uuid, tree_amount: 150},
  {name: 'Block B1', surface: 4, shape_lat_long: '[[11.3426925242798,104.8245537931735],[11.34166404238365,104.8242249418216],[11.34103896398493,104.825357008084],[11.34006824571877,104.8263752710081],[11.340572376197,104.8268078894533],[11.3426925242798,104.8245537931735]]', location_lat_long: '[11.341343,104.825563]', rental_status: 0, status: 0, planting_project_id: 1, farm_id: coconut_farm.uuid, tree_amount: 150},
  {name: 'Block B2', surface: 4, shape_lat_long: '[[11.34054878112665,104.8239343292528],[11.33908393542546,104.8236103777197],[11.33869044981133,104.8233658314196],[11.33830322960425,104.8233274519684],[11.3380561367656,104.8240323114249],[11.34103805033832,104.8253051892459],[11.34163202550639,104.8242335040134],[11.34054878112665,104.8239343292528]]', location_lat_long: '[11.339913,104.824275]', rental_status: 0, status: 0, planting_project_id: 1, farm_id: coconut_farm.uuid, tree_amount: 150},
  {name: 'Block B3', surface: 4, shape_lat_long: '[[11.3380549468293,104.8240472203577],[11.33787545358411,104.8246042945429],[11.34005476537737,104.8263622974383],[11.34102333706613,104.8253242989032],[11.3380549468293,104.8240472203577]]', location_lat_long: '[11.339502,104.825091]', rental_status: 0, status: 0, planting_project_id: 1, farm_id: coconut_farm.uuid, tree_amount: 150},
  {name: 'Block C1', surface: 4, shape_lat_long: '[[11.34024659610298,104.8271098186776],[11.34060069812196,104.8268441183729],[11.33498493139846,104.8223869773665],[11.33533785551793,104.8213092938915],[11.33489589388238,104.8211246009857],[11.33447832386705,104.822553696527],[11.34024659610298,104.8271098186776]]', location_lat_long: '[11.337009,104.824281]', rental_status: 0, status: 0, planting_project_id: 1, farm_id: coconut_farm.uuid, tree_amount: 150}
].each do |block|
  Block.create_with(surface: block[:surface], shape_lat_long: block[:shape_lat_long], location_lat_long: block[:location_lat_long], rental_status: block[:rental_status], status: block[:status], planting_project_id: block[:planting_project_id], farm_id: block[:farm_id], tree_amount: block[:tree_amount]).find_or_create_by(name: block[:name])
end

[
  {name: 'admin', note: 'Controlling all modules', label: 'Admin'},
  {name: 'top_manager', note: 'Can read all modules and download all reports', label: 'TOP Manager'},
  {name: 'officer', note: 'Can input all modules', label: 'Officer'},
  {name: 'it', note: 'Can edit all modules', label: 'IT'}
].each do |role|
  Role.create_with(note: role[:note], label: role[:label]).find_or_create_by(name: role[:name])
end

[ 
  {name: 'User', note: 'Controlling users'},
  {name: 'Warehouse', note: 'Controlling warehouses'},
  {name: 'Labor', note: 'Controlling labors'},
  {name: 'Machinery', note: 'Controlling machineries'},
  {name: 'Material', note: 'Controlling materials'},
  {name: 'Zone', note: 'Controlling zones'}
].each do |resource|
  Resource.create_with(note: resource[:note]).find_or_create_by(name: resource[:name])
end

[ 
  { name: 'Tilling', note: '' },
  { name: 'Planting', note: '' },
  { name: 'Spraying', note: '' },
  { name: 'Fertilizing', note: '' }
].each do |activity|
  ActivityType.create_with(note: activity[:note]).find_or_create_by(name: activity[:name])
end

[ 
  {name: "Manager", note: "Controlling general tasks", active: true},
  {name: "Project Leader", note: "Controlling all projects", active: true},
  {name: "Data Entry", note: "Inputting data", active: true}
].each do |user_group|
  UserGroup.create_with(note: user_group[:note], active: user_group[:active]).find_or_create_by(name: user_group[:name])
end

#Create Administrator group, and add one user to that group
usergroup = UserGroup.create_with(note: "Controlling all resources", active: true).find_or_create_by(name: "Administrator")
user = User.create_with(password: "admin1234567890", password_confirmation: "admin1234567890", role: "admin").find_or_create_by(email: "admin@cltag.com")
usergroup.users << user

[
  {name: 'admin', note: 'Controlling all modules', label: 'Admin'},
  {name: 'top_manager', note: 'Can read all modules and download all reports', label: 'TOP Manager'},
  {name: 'officer', note: 'Can input all modules', label: 'Officer'},
  {name: 'it', note: 'Can edit all modules', label: 'IT'}
].each do |role|
  Role.create_with(note: role[:note], label: role[:label]).find_or_create_by(name: role[:name])
end

[ 
  {name: 'User', note: 'Controlling users'},
  {name: 'Warehouse', note: 'Controlling warehouses'},
  {name: 'Labor', note: 'Controlling labors'},
  {name: 'Machinery', note: 'Controlling machineries'},
  {name: 'Material', note: 'Controlling materials'},
  {name: 'Zone', note: 'Controlling zones'}
].each do |resource|
  Resource.create_with(note: resource[:note]).find_or_create_by(name: resource[:name])
end

[ 
  { name: 'Jackfruit' },
  { name: 'Coconut' }
].each do |project|
  Project.find_or_create_by(name: project[:name])
end

[ 
  { name: 'Tilling', note: 'Tilling trees', label: 'Tilling' },
  { name: 'Planting', note: 'Planting trees', label: 'Planting' },
  { name: 'Fertilizing', note: 'Fertilizing trees', label: 'Fertilizing' },
  { name: 'Harvesting', note: 'Harvesting products', label: 'Harvesting' }
].each do |activity_type|
  ActivityType.create_with(note: activity_type[:note], label: activity_type[:label]).find_or_create_by(name: activity_type[:name])
end

[ 
  { name: 'Stage 1: Nursery (age:1-4month)', period: '4 months', note: 'Phase 1: Seed (Nursery)', fruit_type: 'coconut' },
  { name: 'Stage 2: Planting', period: '45-50 days', note: 'Phase 1: Seed (Nursery)', fruit_type: 'coconut' },
  { name: 'Stage 3: Baby Coconut (age: 1-2 years)', period: '2 years', note: 'Phase 2: Plant Growing & Protection', fruit_type: 'coconut' },
  { name: 'Stage 4: Adult Coconut (Developing age: 3-4 years)', period: '2 years', note: 'Phase 2: Plant Growing & Protection', fruit_type: 'coconut' },
  { name: 'Stage 5: First Production (age: 5-7 years)', period: '3 years', note: 'Phase3: Production & Harvesting', fruit_type: 'coconut' },
  { name: 'Stage 6: Full Production (age: 8-15 years)', period: '8 years', note: 'Phase3: Production & Harvesting', fruit_type: 'coconut' },
  { name: 'Stage 7: Decreasing Production (age: 16-20 years)', period: '5 years', note: 'Phase3: Production & Harvesting', fruit_type: 'coconut' },
  { name: 'Seed Amount', period: 'unknown', note: 'Phase 1: Seed Grafting', fruit_type: 'jackfruit' },
  { name: 'Stage 1: Age 1-3 years', period: '1-3 years', note: 'Phase 2: Plant Growing & Protection', fruit_type: 'jackfruit'},
  { name: 'Stage 2: Age > 4 years', period: 'more than 4 years', note: 'Phase 2: Plant Growing & Protection', fruit_type: 'jackfruit'},
  { name: 'Stage 3: Age 5-15 years', period: '5-15 years', note: 'Phase 3: Harvesting', fruit_type: 'jackfruit'}
  
].each do |stage|
  Stage.create_with(period: stage[:period], note: stage[:note], fruit_type: stage[:fruit_type]).find_or_create_by(name: stage[:name])
end

[
  {name: 'Fertilizer', amount: 3000},
  {name: 'Small Tree', amount: 5000},
  {name: 'Workers', amount: 2000},
  {name: 'Fuel', amount: 10000}
].each do |testing_chart|
  TestingChart.create_with(amount: testing_chart[:amount]).find_or_create_by(name: testing_chart[:name])
end

[
  {element: 'January', amount: 40.49, bar_color: 'silver'},
  {element: 'February', amount: 20.49, bar_color: 'gold'},
  {element: 'March', amount: 20.49, bar_color: 'blue'},
  {element: 'April', amount: 20.49, bar_color: 'green'}
].each do |bar_chart|
  TestingWithBarChart.create_with(bar_color: bar_chart[:bar_color] ,amount: bar_chart[:amount]).find_or_create_by(element: bar_chart[:element])
end

[
  {name: 'Central Warehouse', description: 'It is the big warehouse.'},
  {name: 'Project Warehouse', description: 'It is the warehouse that is near the farms.'},
  {name: 'Finished Goods Warehouse', description: 'It is the warehouse that stock all yields harvest from the farms.'}
].each do |warehouse_type|
  WarehouseType.create_with(description: warehouse_type[:description]).find_or_create_by(name: warehouse_type[:name])
end

[
  {name: 'Stock-in'},
  {name: 'Stock-out'},
  {name: 'Adjustment'}
].each do |transaction_status|
  TransactionStatus.find_or_create_by(name: transaction_status[:name])
end

[
  {project_name: 'Coconut'},
  {project_name: 'Jackfruit'},
  {project_name: 'Mango'}
].each do |planting_project|
  PlantingProject.find_or_create_by(project_name: planting_project[:project_name])
end

[
  {name: 'Tree'},
  {name: 'Kg'},
  {name: 'Ton'},
  {name: 'Litre'}
].each do |unit_measure|
  UnitOfMeasurement.find_or_create_by(name: unit_measure[:name])
end