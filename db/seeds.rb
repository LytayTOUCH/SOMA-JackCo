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
  Activity.create_with(note: activity[:note]).find_or_create_by(name: activity[:name])
end

[ 
  { name: 'Jackfruit' },
  { name: 'Coconut' }
].each do |project|
  Project.find_or_create_by(name: project[:name])
end
