# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
