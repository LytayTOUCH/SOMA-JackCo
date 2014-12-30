# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

ActivityType.create(name: 'Tilling', note: 'Tilling trees')
ActivityType.create(name: 'Planting', note: 'Planting trees')
ActivityType.create(name: 'Fertilizing', note: 'Fertilizing trees')
ActivityType.create(name: 'Harvesting', note: 'Harvesting products')

User.create!({email: "teopaocheak@yahoo.com", password: "12345678", password_confirmation: "12345678", role: 'admin'})