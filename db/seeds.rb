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
  {email: "admin@cltag.com", password: "admin1234567890", password_confirmation: "admin1234567890", role: 'admin'}
].each do |user|
  User.create_with(password: user[:password], password_confirmation: user[:password_confirmation], role: user[:role]).find_or_create_by(email: user[:email])
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
  {name: 'Ml'},
  {name: 'Litre'}
].each do |unit_measure|
  UnitOfMeasurement.find_or_create_by(name: unit_measure[:name])
end

[
  {name: 'FERTILIZERS'},
  {name: 'PEST & INSECTICIDES'},
  {name: 'FUNGICIDE'},
  {name: 'HERBICIDE'}
].each do |material_category|
  MaterialCategory.find_or_create_by(name: material_category[:name])
end