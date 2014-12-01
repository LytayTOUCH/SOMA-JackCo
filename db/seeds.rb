# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

UserGroup.create(name: 'admin', note: 'Controlling all modules')
UserGroup.create(name: 'stock manager', note: 'Controlling stocks module')
UserGroup.create(name: 'sale manager', note: 'Controlling sales module')
UserGroup.create(name: 'request manager', note: 'Controlling making requests module')
UserGroup.create(name: 'account manager', note: 'Controlling accounts module')
UserGroup.create(name: 'purchase manager', note: 'Controlling purchasing module')
UserGroup.create(name: 'planting assist manager', note: 'Controlling planting assist module')
UserGroup.create(name: 'service department manager', note: 'Controlling service departments module')