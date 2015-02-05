# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


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
  {email: "admin@gmail.com", password: "admin", password_confirmation: "admin", role: 'admin'}
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
  { name: 'Stage 1: Nursery (age:1-4month)', period: '4 months', note: 'Phase 1: Seed (Nursery)' },
  { name: 'Stage 2: Planting', period: '45-50 days', note: 'Phase 1: Seed (Nursery)' },
  { name: 'Stage 3: Baby Coconut (age: 1-2 years)', period: '2 years', note: 'Phase 2: Plant Growing & Protection' },
  { name: 'Stage 4: Adult Coconut (Developing age: 3-4 years)', period: '2 years', note: 'Phase 2: Plant Growing & Protection' },
  { name: 'Stage 5: First Production (age: 5-7 years)', period: '3 years', note: 'Phase3: Production & Harvesting' },
  { name: 'Stage 6: Full Production (age: 8-15 years)', period: '8 years', note: 'Phase3: Production & Harvesting' },
  { name: 'Stage 7: Decreasing Production (age: 16-20 years)', period: '5 years', note: 'Phase3: Production & Harvesting' }
].each do |stage|
  Stage.create_with(period: stage[:period], note: stage[:note]).find_or_create_by(name: stage[:name])
end

User.create!({email: "teopaocheak@yahoo.com", password: "12345678", password_confirmation: "12345678", role: 'admin'})

Role.create(name: 'admin', note: 'Controlling all modules', label: 'Admin')
Role.create(name: 'top_manager', note: 'Can read all modules and download all reports', label: 'TOP Manager')
Role.create(name: 'officer', note: 'Can input all modules', label: 'Officer')
Role.create(name: 'it', note: 'Can edit all modules', label: 'IT')

Resource.create(name: 'User', note: 'Controlling users')
Resource.create(name: 'Warehouse', note: 'Controlling warehouses')
Resource.create(name: 'Labor', note: 'Controlling labors')
Resource.create(name: 'Machinery', note: 'Controlling machineries')
Resource.create(name: 'Material', note: 'Controlling materials')
Resource.create(name: 'Zone', note: 'Controlling zones')

# run:
# rake db:seed

Project.create([{ name: 'Jackfruit' }, { name: 'Coconut' }])

ActivityType.create(name: 'Tilling', note: 'Tilling trees', label: 'Tilling')
ActivityType.create(name: 'Planting', note: 'Planting trees', label: 'Planting')
ActivityType.create(name: 'Fertilizing', note: 'Fertilizing trees', label: 'Fertilizing')
ActivityType.create(name: 'Harvesting', note: 'Harvesting products', label: 'Harvesting')

Stage.create(name: 'Stage 1: Nursery (age:1-4month)', period: '4 months', note: 'Phase 1: Seed (Nursery)', fruit_type: 'coconut')
Stage.create(name: 'Stage 2: Planting', period: '45-50 days', note: 'Phase 1: Seed (Nursery)', fruit_type: 'coconut')
Stage.create(name: 'Stage 3: Baby Coconut (age: 1-2 years)', period: '2 years', note: 'Phase 2: Plant Growing & Protection', fruit_type: 'coconut')
Stage.create(name: 'Stage 4: Adult Coconut (Developing age: 3-4 years)', period: '2 years', note: 'Phase 2: Plant Growing & Protection', fruit_type: 'coconut')
Stage.create(name: 'Stage 5: First Production (age: 5-7 years)', period: '3 years', note: 'Phase3: Production & Harvesting', fruit_type: 'coconut')
Stage.create(name: 'Stage 6: Full Production (age: 8-15 years)', period: '8 years', note: 'Phase3: Production & Harvesting', fruit_type: 'coconut')
Stage.create(name: 'Stage 7: Decreasing Production (age: 16-20 years)', period: '5 years', note: 'Phase3: Production & Harvesting', fruit_type: 'coconut')

Stage.create(name: 'Seed Amount', period: 'unknown', note: 'Phase 1: Seed Grafting', fruit_type: 'jackfruit')
Stage.create(name: 'Stage 1: Age 1-3 years', period: '1-3 years', note: 'Phase 2: Plant Growing & Protection', fruit_type: 'jackfruit')
Stage.create(name: 'Stage 2: Age > 4 years', period: 'more than 4 years', note: 'Phase 2: Plant Growing & Protection', fruit_type: 'jackfruit')
Stage.create(name: 'Stage 3: Age 5-15 years', period: '5-15 years', note: 'Phase 3: Harvesting', fruit_type: 'jackfruit')

TestingChart.create(name: 'Fertilizer', amount: 3000)
TestingChart.create(name: 'Small Tree', amount: 5000)
TestingChart.create(name: 'Workers', amount: 2000)
TestingChart.create(name: 'Fuel', amount: 10000)
