# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

<<<<<<< HEAD
UserGroup.create(name: 'admin', note: 'Controlling all modules', label: 'Admin')
UserGroup.create(name: 'stock_manager', note: 'Controlling stocks module', label: 'Stock Manager')
UserGroup.create(name: 'sale_manager', note: 'Controlling sales module', label: 'Sale Manager')
UserGroup.create(name: 'request_manager', note: 'Controlling making requests module', label: 'Request Manager')
UserGroup.create(name: 'account_manager', note: 'Controlling accounts module', label: 'Account Manager')
UserGroup.create(name: 'purchase_manager', note: 'Controlling purchasing module', label: 'Purchase Manager')
UserGroup.create(name: 'planting_assist_manager', note: 'Controlling planting assist module', label: 'Planting Assist Manager')
UserGroup.create(name: 'service_department_manager', note: 'Controlling service departments module', label: 'Service Department Manager')

Resource.create(name: 'User', note: 'Controlling users')
Resource.create(name: 'Warehouse', note: 'Controlling warehouses')
Resource.create(name: 'Labor', note: 'Controlling labors')
Resource.create(name: 'Machinery', note: 'Controlling machineries')
Resource.create(name: 'Material', note: 'Controlling materials')
Resource.create(name: 'Zone', note: 'Controlling zones')
=======
# run:
# rake db:seed

Project.create([{ name: 'Jackfruit' }, { name: 'Coconut' }])
>>>>>>> maintenance
