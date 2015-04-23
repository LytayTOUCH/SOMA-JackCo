# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# run:
# rake db:seed
# ========== Machinery Type ==========
[
  {uuid: '00000000-0000-0000-0000-000000000001', name: 'Tractor', note: 'Tractor', status: true},
  {uuid: '00000000-0000-0000-0000-000000000002', name: 'Excavator', note: 'Excavator', status: true},
  {uuid: '00000000-0000-0000-0000-000000000003', name: 'Grass Cutter', note: 'Grass Cutter', status: true}
].each do |machinery_type|
  MachineryType.create_with(name: machinery_type[:name], note: machinery_type[:note], status: machinery_type[:status]).find_or_create_by(uuid: machinery_type[:uuid])
end

# ========== Position ==========
[
  {name: 'Manager', note: 'Controlling a labor in field', active: true},
  {name: 'Worker', note: 'Doing farming in the field', active: true}
].each do |position|
  Position.create_with(note: position[:note]).find_or_create_by(name: position[:name])
end

# ========== Labor ==========
position = Position.create_with(note: 'Controlling a labor in field', active: true).find_or_create_by(name: 'Manager')
labor = Labor.create_with(gender: "M", phone: "012 345 678", email: "admin@cltag.com", address: "Phnom Penh", manager_uuid: "", note: "Controlling all the labors in the field", active: true, selected: true).find_or_create_by(name: "Default Manager")
position.labors << labor

# ========== Create Setting ========== 
[
  {code: 'item_per_page', note: 'Amount of item show in a list per page', valueType: 'INT', valueInteger: 10, valueString: nil, valueFloat: nil}
].each do |setting|
  Setting.create_with(note: setting[:note], valueType: setting[:valueType], valueInteger: setting[:valueInteger], valueString: setting[:valueString], valueFloat: setting[:valueFloat]).find_or_create_by(code: setting[:code])
end

# ==========  Create UserGroup ========== 
[ 
  {name: "Administrator", note: "Controlling everything", active: true},
  {name: "Manager", note: "Controlling general tasks", active: true},
  {name: "Project Leader", note: "Controlling all projects", active: true},
  {name: "Data Entry", note: "Inputting data", active: true}
].each do |user_group|
  userg = UserGroup.create_with(note: user_group[:note], active: user_group[:active]).find_or_create_by(name: user_group[:name])
end

# ========== Create a User ========== 
user_group = UserGroup.create_with(note: "Controlling all resources", active: true).find_or_create_by(name: "Administrator")
# labor = Labor.create_with(gender: "M", phone: "012 345 678", email: "admin@gmail.com", address: "Phnom Penh", manager_uuid: "", note: "Controlling all the labors in the field", active: true)
user = User.create_with(password: "admin1234567890", password_confirmation: "admin1234567890", user_group_id: user_group.uuid, labor_id: labor.uuid).find_or_create_by(email: "admin@cltag.com")

user_group.users << user

# ========== Create Projects ========== 
[ 
  { name: 'Jackfruit' },
  { name: 'Coconut' }
].each do |project|
  Project.find_or_create_by(name: project[:name])
end

# ========== Create Activity types ========== 
[ 
  { name: 'Tilling', note: 'Tilling trees', label: 'Tilling' },
  { name: 'Planting', note: 'Planting trees', label: 'Planting' },
  { name: 'Fertilizing', note: 'Fertilizing trees', label: 'Fertilizing' },
  { name: 'Harvesting', note: 'Harvesting products', label: 'Harvesting' }
].each do |activity_type|
  ActivityType.create_with(note: activity_type[:note], label: activity_type[:label]).find_or_create_by(name: activity_type[:name])
end

# ========== Create Data for Pie Chart ========== 
[
  {name: 'Fertilizer', amount: 3000},
  {name: 'Small Tree', amount: 5000},
  {name: 'Workers', amount: 2000},
  {name: 'Fuel', amount: 10000}
].each do |testing_chart|
  TestingChart.create_with(amount: testing_chart[:amount]).find_or_create_by(name: testing_chart[:name])
end

# ========== Create Data for Bar Chart ========== 
[
  {element: 'Actual', amount: 40.00, bar_color: 'gold'},
  {element: 'Forecast', amount: 40.50, bar_color: 'blue'},
  {element: 'Stardard', amount: 35.50, bar_color: 'green'}
].each do |bar_chart|
  TestingWithBarChart.create_with(bar_color: bar_chart[:bar_color] ,amount: bar_chart[:amount]).find_or_create_by(element: bar_chart[:element])
end

# ========== Create Warehouse Types ========== 
[
  {name: 'Central Warehouse', note: 'It is the big warehouse.'},
  {name: 'Fertilizer Warehouse', note: 'It is the warehouse that is used to store the fertilizer.'},
  {name: 'Project Warehouse', note: 'It is the warehouse that is near the farms.'},
  {name: 'Finished Goods Warehouse', note: 'It is the warehouse that stock all yields harvest from the farms.'},
  {name: 'Nursery Warehouse', note: 'It is the plant nursery warehouse.'}
].each do |warehouse_type|
  WarehouseType.create_with(note: warehouse_type[:note]).find_or_create_by(name: warehouse_type[:name])
end

# ========== Create Planting Projects ========== 
[
  {name: 'Coconut'},
  {name: 'Jackfruit'},
  {name: 'Mango'},
  {name: 'Lemon'}
].each do |planting_project|
  PlantingProject.find_or_create_by(name: planting_project[:name])
end

# ========== Create Unit of Measurement ==========
[
  {name: 'Unit', note: 'Unit of measurement for tree, amount of fruit,...'},
  {name: 'Kg', note: 'Unit of measurement for kilogram.'},
  {name: 'g', note: 'Unit of measurement for gram.'},
  {name: 'L', note: 'Unit of measurement for litre.'},
  {name: 'mL', note: 'Unit of measurement for mili-litre.'}
].each do |unit_measure|
  UnitOfMeasurement.create_with(note: unit_measure[:note]).find_or_create_by(name: unit_measure[:name])
end

# ========== Create Material Categories ========== 
[
  {name: 'Fertilizers', kh_name: 'ជីបំប៉នដំណាំ', note: 'Fertilizer note'},
  {name: 'Pest & Insecticides', kh_name: 'ថ្នាំសំលាប់សត្វល្អិត', note: 'Pest and Insecticide note'},
  {name: 'Fungicides', kh_name: 'ថ្នាំសំលាប់ផ្សិត', note: 'Fungicide note'},
  {name: 'Herbicides', kh_name: 'ថ្នាំសំលាប់ស្មៅ', note: 'Herbicide note'},
  {name: 'Indirect Materials', kh_name: 'សម្ភារៈប្រយោល', note: 'Herbicide note'},
  {name: 'Other', kh_name: 'សម្ភារៈផ្សេងៗ', note: 'Herbicide note'}
].each do |material_category|
  MaterialCategory.create_with(note: material_category[:note], kh_name: material_category[:kh_name]).find_or_create_by(name: material_category[:name])
end
# ========== Create Farms ==========
[
  {name: 'Oroung Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.333019, 104.864575', active: true},
  {name: 'Chamkar Doung Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.341900, 104.822941', active: true},
  {name: 'Otaroit Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.336964, 104.830418', active: true},
  {name: 'Kapet Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.336681, 104.858414', active: true},
  {name: 'Kbalsen Farm', location: 'Bati District, Takeo Province', latlong_farm: '11.336839, 104.858196', active: true}
  # {name: 'Kampot Farm', location: 'Beurng Chhouk District, Kampot Province', latlong_farm: '10.572342, 104.132600', active: true}
].each do |farm|
  Farm.create_with(location: farm[:location], latlong_farm: farm[:latlong_farm], active: farm[:active]).find_or_create_by(name: farm[:name])
end

coconut_farm = Farm.find_by_name('Chamkar Doung Farm')
oroung_farm= Farm.find_by_name('Oroung Farm')
otaroit_farm= Farm.find_by_name('Otaroit Farm')
kapet_farm= Farm.find_by_name('Kapet Farm')
kbalsen_farm= Farm.find_by_name('Kbalsen Farm')
# kampot_farm= Farm.find_by_name('Kampot Farm')
coconut_planting_project=PlantingProject.find_by_name('Coconut')
jackfruit_planting_project=PlantingProject.find_by_name('Jackfruit')

#=========== Zone ===============
[
  {name:'Zone-I', farm_id: coconut_farm.uuid},
  {name:'Zone-II', farm_id: coconut_farm.uuid},
  {name:'Zone-III', farm_id: coconut_farm.uuid},
  {name:'Zone-IV', farm_id: coconut_farm.uuid},
  {name:'Zone-V', farm_id: coconut_farm.uuid},
  {name:'Zone-IV', farm_id: otaroit_farm.uuid},
  {name:'Zone-II', farm_id: kapet_farm.uuid},
  {name:'Zone-III', farm_id: kbalsen_farm.uuid},
  {name:'Zone-I', farm_id: oroung_farm.uuid},
  {name:'Zone-II', farm_id: kapet_farm.uuid}
  # {name:'Zone-I', farm_id: kampot_farm.uuid},
  # {name:'Zone-II', farm_id: kampot_farm.uuid},
  # {name:'Zone-III', farm_id: kampot_farm.uuid},
].each do |zone|
  Zone.create_with(name: zone[:name], farm_id: zone[:farm_id]).find_or_create_by(name: zone[:name], farm_id: zone[:farm_id])
end
chamkar_doung_zone_i = Zone.find_by_name_and_farm_id('Zone-I', coconut_farm.uuid)
chamkar_doung_zone_ii = Zone.find_by_name_and_farm_id('Zone-II', coconut_farm.uuid)
chamkar_doung_zone_iii = Zone.find_by_name_and_farm_id('Zone-III', coconut_farm.uuid)
chamkar_doung_zone_iv = Zone.find_by_name_and_farm_id('Zone-IV', coconut_farm.uuid)
chamkar_doung_zone_v = Zone.find_by_name_and_farm_id('Zone-V', coconut_farm.uuid)
otaroit_zone_iv = Zone.find_by_name_and_farm_id('Zone-IV', otaroit_farm.uuid)
kapet_zone_ii = Zone.find_by_name_and_farm_id('Zone-II', kapet_farm.uuid)
kbalsen_zone_iii= Zone.find_by_name_and_farm_id('Zone-III', kbalsen_farm.uuid)
oroung_zone_i = Zone.find_by_name_and_farm_id('Zone-I', oroung_farm.uuid)
# kampot_zone_i = Zone.find_by_name_and_farm_id('Zone-I', kampot_farm.uuid)
# kampot_zone_ii = Zone.find_by_name_and_farm_id('Zone-II', kampot_farm.uuid)

#=========== Area ===============
[
  {name: 'A', zone_id: chamkar_doung_zone_i.uuid},
  {name: 'B', zone_id: chamkar_doung_zone_i.uuid},
  {name: 'C', zone_id: chamkar_doung_zone_i.uuid},
  {name: 'D', zone_id: chamkar_doung_zone_ii.uuid},
  {name: 'E', zone_id: chamkar_doung_zone_ii.uuid},
  {name: 'F', zone_id: chamkar_doung_zone_iii.uuid},
  {name: 'G', zone_id: chamkar_doung_zone_iii.uuid},
  {name: 'A', zone_id: chamkar_doung_zone_iv.uuid},
  {name: 'I', zone_id: chamkar_doung_zone_v.uuid},
  {name: 'J', zone_id: chamkar_doung_zone_v.uuid},
  {name: 'H', zone_id: otaroit_zone_iv.uuid},
  {name: 'A', zone_id: kbalsen_zone_iii.uuid},
  {name: 'A', zone_id: kapet_zone_ii.uuid},
  {name: 'B', zone_id: kapet_zone_ii.uuid},
  {name: 'A', zone_id: oroung_zone_i.uuid},
  {name: 'B', zone_id: oroung_zone_i.uuid},
  {name: 'C', zone_id: oroung_zone_i.uuid}
  # {name: 'A', zone_id: kampot_zone_i.uuid},
  # {name: 'B', zone_id: kampot_zone_i.uuid},
  # {name: 'C', zone_id: kampot_zone_ii.uuid},
  # {name: 'D', zone_id: kampot_zone_ii.uuid}
].each do |area|
  Area.create_with(name: area[:name], zone_id: area[:zone_id]).find_or_create_by(name: area[:name], zone_id: area[:zone_id])
end

chamkar_doung_area_a = Area.find_by_name_and_zone_id('A', chamkar_doung_zone_i.uuid)
chamkar_doung_area_b = Area.find_by_name_and_zone_id('B', chamkar_doung_zone_i.uuid)
chamkar_doung_area_c = Area.find_by_name_and_zone_id('C', chamkar_doung_zone_i.uuid)
chamkar_doung_area_d = Area.find_by_name_and_zone_id('D', chamkar_doung_zone_ii.uuid)
chamkar_doung_area_e = Area.find_by_name_and_zone_id('E', chamkar_doung_zone_ii.uuid)
chamkar_doung_area_f = Area.find_by_name_and_zone_id('F', chamkar_doung_zone_iii.uuid)
chamkar_doung_area_g = Area.find_by_name_and_zone_id('G', chamkar_doung_zone_iii.uuid)
chamkar_doung_area_i = Area.find_by_name_and_zone_id('I', chamkar_doung_zone_v.uuid)
chamkar_doung_area_j = Area.find_by_name_and_zone_id('J', chamkar_doung_zone_v.uuid)
chamkar_doung_area_h = Area.find_by_name_and_zone_id('H', otaroit_zone_iv.uuid)
chamkar_doung_jackfruit_area_a = Area.find_by_name_and_zone_id('A', chamkar_doung_zone_iv.uuid)
kbalsen_area_a = Area.find_by_name_and_zone_id('A', kbalsen_zone_iii.uuid)
kapet_area_a = Area.find_by_name_and_zone_id('A', kapet_zone_ii.uuid)
kapet_area_b = Area.find_by_name_and_zone_id('B', kapet_zone_ii.uuid)
kapet_area_c = Area.find_by_name_and_zone_id('C', kapet_zone_ii.uuid)
oroung_area_a = Area.find_by_name_and_zone_id('A', oroung_zone_i.uuid)
oroung_area_b = Area.find_by_name_and_zone_id('B', oroung_zone_i.uuid)
oroung_area_c = Area.find_by_name_and_zone_id('C', oroung_zone_i.uuid)
# kampot_area_a = Area.find_by_name_and_zone_id('A', kampot_zone_i.uuid)
# kampot_area_b = Area.find_by_name_and_zone_id('B', kampot_zone_i.uuid)
# kampot_area_c = Area.find_by_name_and_zone_id('C', kampot_zone_ii.uuid)
# kampot_area_d = Area.find_by_name_and_zone_id('D', kampot_zone_ii.uuid)

# ========== Create Blocks for All Farms ==========
[
  {uuid: '00000000-0000-0000-0000-000000000001', name: 'Block A1', area_id: chamkar_doung_area_a.uuid, surface: 4, shape_lat_long: '[[11.34228844248775,104.8173368444448],[11.34222380000888,104.8171604557845],[11.3419655618982,104.8170819933822],[11.34197186349495,104.8169376349896],[11.34152765634626,104.8168564506022],[11.34152565378016,104.8161860309814],[11.34072187781601,104.8161618977276],[11.34073587728222,104.8166945670797],[11.34083425409179,104.8171092601984],[11.34104359934694,104.8174874094787],[11.34114577172203,104.8181746246259],[11.34214745471061,104.8184887833901],[11.34225258745473,104.8181561580298],[11.34287072363673,104.8182904066128],[11.34309297859914,104.8175375089032],[11.34228844248775,104.8173368444448]]', location_lat_long: '11.341907428207575, 104.81732534055891', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 184, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000002', name: 'Block A2', area_id: chamkar_doung_area_a.uuid, surface: 4, shape_lat_long: '[[11.34120932973546,104.8183803286982],[11.34112138334435,104.8184150176988],[11.34092905012725,104.8183922652106],[11.34081065229375,104.8186381489472],[11.34173900706889,104.8191704886344],[11.34189976470813,104.8186003149401],[11.34120932973546,104.8183803286982]]', location_lat_long: '11.34135520850094, 104.81877540866628', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 109, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000003', name: 'Block B1', area_id: chamkar_doung_area_b.uuid, surface: 4, shape_lat_long: '[[11.3426925242798,104.8245537931735],[11.34166404238365,104.8242249418216],[11.34103896398493,104.825357008084],[11.34006824571877,104.8263752710081],[11.340572376197,104.8268078894533],[11.3426925242798,104.8245537931735]]', location_lat_long: '11.341380384999285, 104.82551641563748', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 509, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000004', name: 'Block B2', area_id: chamkar_doung_area_b.uuid, surface: 4, shape_lat_long: '[[11.34054878112665,104.8239343292528],[11.33908393542546,104.8236103777197],[11.33869044981133,104.8233658314196],[11.33830322960425,104.8233274519684],[11.3380561367656,104.8240323114249],[11.34103805033832,104.8253051892459],[11.34163202550639,104.8242335040134],[11.34054878112665,104.8239343292528]]', location_lat_long: '11.339844081135995, 104.82431632060718', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 670, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000005', name: 'Block B3', area_id: chamkar_doung_area_b.uuid, surface: 4, shape_lat_long: '[[11.3380549468293,104.8240472203577],[11.33787545358411,104.8246042945429],[11.34005476537737,104.8263622974383],[11.34102333706613,104.8253242989032],[11.3380549468293,104.8240472203577]]', location_lat_long: '11.339449395325119, 104.82520475889805', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 931, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000006', name: 'Block C1', area_id: chamkar_doung_area_c.uuid, surface: 4, shape_lat_long: '[[11.34024659610298,104.8271098186776],[11.34060069812196,104.8268441183729],[11.33498493139846,104.8223869773665],[11.33533785551793,104.8213092938915],[11.33489589388238,104.8211246009857],[11.33447832386705,104.822553696527],[11.34024659610298,104.8271098186776]]', location_lat_long: '11.337539510994505, 104.82411720983168', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 870, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000007', name: 'Block C2', area_id: chamkar_doung_area_c.uuid, surface: 4, shape_lat_long: '[[11.33487202501744,104.8211036153992],[11.33525920583094,104.8212623951001],[11.33612648549367,104.8183899564419],[11.33533440487928,104.8180970198423],[11.33409866275981,104.8222732893141],[11.33444645674763,104.8225375923322],[11.33487202501744,104.8211036153992]]', location_lat_long: '11.33511257412674, 104.82031730608719', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 370, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000008', name: 'Block C3', area_id: chamkar_doung_area_c.uuid, surface: 4, shape_lat_long: '[[11.33734549627795,104.8159576082747],[11.33601884622914,104.8156118216062],[11.33573959032024,104.8168221399481],[11.33690316287407,104.8172399890616],[11.3378909815109,104.8177818381605],[11.33879968483595,104.8181850123367],[11.33880953469512,104.8183465097908],[11.33926693493995,104.8185963130855],[11.33986282882176,104.8186511316346],[11.34024710972461,104.8184728409923],[11.34041486814646,104.8184374427987],[11.34032466367863,104.8166264232303],[11.33734549627795,104.8159576082747]]', location_lat_long: '11.338077229233349, 104.81713147662037', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1556, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000009', name: 'Block D1', area_id: chamkar_doung_area_d.uuid, surface: 4, shape_lat_long: '[[11.33900396631398,104.8085254948515],[11.3379264872429,104.8115689374645],[11.33971225670561,104.8120395908525],[11.3408902230842,104.8089847526479],[11.33900396631398,104.8085254948515]]', location_lat_long: '11.339408355163549, 104.81028254285195', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1251, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000010', name: 'Block D2', area_id: chamkar_doung_area_d.uuid, surface: 4, shape_lat_long: '[[11.33714357224421,104.8081020834078],[11.33607100737304,104.8111208999755],[11.33790069342142,104.8115756245518],[11.33896551998137,104.8085186716411],[11.33714357224421,104.8081020834078]]', location_lat_long: '11.337518263677204, 104.80983885397973', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1321, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000011', name: 'Block D3', area_id: chamkar_doung_area_d.uuid, surface: 4, shape_lat_long: '[[11.33532149460082,104.8076322212488],[11.33425726284938,104.8106703615392],[11.33605047733483,104.8111111650765],[11.337112743697,104.8081022485678],[11.33532149460082,104.8076322212488]]', location_lat_long: '11.335685003273191, 104.80937169316257', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1299, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000012', name: 'Block D4', area_id: chamkar_doung_area_d.uuid, surface: 4, shape_lat_long: '[[11.33350479078079,104.8071058636902],[11.33287059713584,104.808922856131],[11.33477988586729,104.8091372985877],[11.33529182323817,104.8076039616002],[11.33350479078079,104.8071058636902]]', location_lat_long: '11.334081210187005, 104.80812158113895', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 767, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000013', name: 'Block D5', area_id: chamkar_doung_area_d.uuid, surface: 4, shape_lat_long: '[[11.33163078081586,104.806561894233],[11.33100788516519,104.8084412419834],[11.3328203413864,104.808938123778],[11.33346326626372,104.8070915843223],[11.33163078081586,104.806561894233]]', location_lat_long: '11.332235575714456, 104.80775000900553', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 812, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000014', name: 'Block E1', area_id: chamkar_doung_area_e.uuid, surface: 4, shape_lat_long: '[[11.34049649875528,104.8127362500604],[11.34048099122345,104.8122712099776],[11.33974145345752,104.812056148033],[11.33912208419224,104.8138503684407],[11.34091411326864,104.8143098769151],[11.34141211951846,104.8129502692697],[11.34049649875528,104.8127362500604]]', location_lat_long: '11.34026710185535, 104.81318301247404', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 923, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000015', name: 'Block E2', area_id: chamkar_doung_area_e.uuid, surface: 4, shape_lat_long: '[[11.33789387964987,104.8115928886557],[11.33726421923066,104.8133776504536],[11.33909415636649,104.8138459212008],[11.33971377730665,104.8120626717394],[11.33789387964987,104.8115928886557]]', location_lat_long: '11.338488998268655, 104.8127194049282', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1170, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000016', name: 'Block E3', area_id: chamkar_doung_area_e.uuid, surface: 4, shape_lat_long: '[[11.33606408292385,104.8111662065589],[11.33569375113498,104.8120703541112],[11.33655378306343,104.8122370676592],[11.33617928390121,104.8139989922181],[11.33694281672026,104.8142203045922],[11.33785678808191,104.8116043138193],[11.33606408292385,104.8111662065589]]', location_lat_long: '11.336775269608445, 104.8126932555756', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 650, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000017', name: 'Block E4', area_id: chamkar_doung_area_e.uuid, surface: 4, shape_lat_long: '[[11.33423564392966,104.8106861443795],[11.3335861308068,104.8124688468133],[11.33483180707202,104.8127619811578],[11.33503518165923,104.812079986203],[11.33566733839669,104.8120752878286],[11.3360425415772,104.811132980767],[11.33423564392966,104.8106861443795]]', location_lat_long: '11.334814336192, 104.81172406276869', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 709, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000018', name: 'Block E5', area_id: chamkar_doung_area_e.uuid, surface: 4, shape_lat_long: '[[11.33237458805498,104.8102130790267],[11.33175470832986,104.8119990632549],[11.33355691837696,104.8124587011756],[11.33420732142131,104.8106624129675],[11.33237458805498,104.8102130790267]]', location_lat_long: '11.332981014875585, 104.81133589010119', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 841, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000019', name: 'Block E6', area_id: chamkar_doung_area_e.uuid, surface: 4, shape_lat_long: '[[11.33054427881204,104.8096732940094],[11.32986115454789,104.8114897466205],[11.33172576273692,104.8119912444923],[11.33238616830127,104.8101528183327],[11.33054427881204,104.8096732940094]]', location_lat_long: '11.33112366142458, 104.8108322692508', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 841, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000020', name: 'Block F1', area_id: chamkar_doung_area_f.uuid, surface: 4, shape_lat_long: '[[11.33410256733272,104.8165630366231],[11.33354683783979,104.8181337095758],[11.33415087078152,104.8182785503407],[11.33455066185946,104.8185118015493],[11.33512608449261,104.8186503220459],[11.33563622942507,104.8169925265802],[11.33410256733272,104.8165630366231]]', location_lat_long: '11.33459153363243, 104.81760667933452', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 656, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000021', name: 'Block F2', area_id: chamkar_doung_area_f.uuid, surface: 4, shape_lat_long: '[[11.33609545254499,104.815076336362],[11.33479075834423,104.8147626151813],[11.33412835242708,104.8165466682644],[11.33564383317245,104.8169666489786],[11.33609545254499,104.815076336362]]', location_lat_long: '11.335111902486034, 104.81586463207998', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 510, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000022', name: 'Block F3', area_id: chamkar_doung_area_f.uuid, surface: 4, shape_lat_long: '[[11.33615178781224,104.8140109689375],[11.33624762533694,104.8134188808902],[11.33532810575154,104.8131730989206],[11.33479404884914,104.8147433372197],[11.33603564644794,104.815052085761],[11.33615617435133,104.8145203240758],[11.33638962597368,104.8144678393152],[11.33645819657116,104.814134963324],[11.33615178781224,104.8140109689375]]', location_lat_long: '11.33562612271015, 104.81411259234073', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 434, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000023', name: 'Block F4', area_id: chamkar_doung_area_f.uuid, surface: 4, shape_lat_long: '[[11.33529116366221,104.8132018048545],[11.33491251773302,104.8131037408055],[11.33499775238072,104.8128287147316],[11.33358492186474,104.8124905508137],[11.3329395824472,104.8142566249857],[11.33477701422848,104.814739334562],[11.33529116366221,104.8132018048545]]', location_lat_long: '11.334115373054704, 104.81361494268776', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 842, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000024', name: 'Block F5', area_id: chamkar_doung_area_f.uuid, surface: 4, shape_lat_long: '[[11.33173941333774,104.8120178624077],[11.33108085327345,104.8137951222362],[11.33289550696729,104.8142483264799],[11.33355692870287,104.8124743242104],[11.33173941333774,104.8120178624077]]', location_lat_long: '11.33231889098816, 104.81313309444374', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 841, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000025', name: 'Block F6', area_id: chamkar_doung_area_f.uuid, surface: 4, shape_lat_long: '[[11.32987211191724,104.8115245854796],[11.32922540747626,104.8133144151218],[11.33104300406534,104.8138057666027],[11.33170556916614,104.812009366642],[11.32987211191724,104.8115245854796]]', location_lat_long: '11.330465488321199, 104.81266517604115', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 840, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000026', name: 'Block G1', area_id: chamkar_doung_area_g.uuid, surface: 4, shape_lat_long: '[[11.33293169741414,104.8142869805426],[11.33231474965486,104.8160730710264],[11.33408746941777,104.8165371268642],[11.33474555897157,104.8147614488461],[11.33293169741414,104.8142869805426]]', location_lat_long: '11.333530154313214, 104.81541205370343', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 816, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000027', name: 'Block G2', area_id: chamkar_doung_area_g.uuid, surface: 4, shape_lat_long: '[[11.33106844579823,104.8138112353617],[11.33044291361138,104.8156173280431],[11.33225814866549,104.8160549746723],[11.33289815291077,104.8142568629447],[11.33106844579823,104.8138112353617]]', location_lat_long: '11.331670533261075, 104.81493310501696', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 841, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000028', name: 'Block G3', area_id: chamkar_doung_area_g.uuid, surface: 4, shape_lat_long: '[[11.32921824010071,104.8133266599871],[11.32861664012218,104.8151529110489],[11.33041475883735,104.815604158173],[11.33105052478399,104.8138130016391],[11.32921824010071,104.8133266599871]]', location_lat_long: '11.329833582453084, 104.81446540908007', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 841, fruitful_tree: 10, active: true},
  {uuid: '00000000-0000-0000-0000-000000000029', name: 'Block G4', area_id: chamkar_doung_area_g.uuid, surface: 4, shape_lat_long: '[[11.33406930449462,104.8165567830023],[11.33292371860223,104.816277996373],[11.33299351419022,104.8173037974456],[11.33192689020778,104.8172904036948],[11.33174473721836,104.8176523861268],[11.33227473405949,104.8177652863685],[11.33278321504721,104.817890499029],[11.33329633084045,104.8180678708238],[11.33352097809366,104.8181264665126],[11.33406930449462,104.8165567830023]]', location_lat_long: '11.332907020856489, 104.8172022314427', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 290, fruitful_tree: 165, active: true},
  {uuid: '00000000-0000-0000-0000-000000000030', name: 'Block G5', area_id: chamkar_doung_area_g.uuid, surface: 4, shape_lat_long: '[[11.33042489468227,104.8156431543584],[11.32978196739425,104.8174658374582],[11.32995263579721,104.8175307188736],[11.33016265816842,104.8175532285823],[11.33061729180989,104.8175795522391],[11.33110657005421,104.8175694820784],[11.33173463463652,104.8176141611531],[11.33185408392004,104.8172375995946],[11.33175807831167,104.8162183513594],[11.33226419893829,104.8160860634427],[11.33042489468227,104.8156431543584]]', location_lat_long: '11.33102308316627, 104.8166286577557', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 738, fruitful_tree: 136, active: true},
  {uuid: '00000000-0000-0000-0000-000000000031', name: 'Block G6', area_id: chamkar_doung_area_g.uuid, surface: 4, shape_lat_long: '[[11.3286085550757,104.8151678225153],[11.32810445822384,104.8172720784721],[11.3284358243916,104.8173695482883],[11.32848866865602,104.817306828748],[11.32862773704232,104.8172509767068],[11.32873793365467,104.8172204336925],[11.32886357889964,104.8172101725763],[11.32902980712842,104.817191848919],[11.32913844778859,104.8171949006022],[11.32935685263874,104.8172202329906],[11.32942261674144,104.817254299895],[11.32958148840606,104.8173906850691],[11.32974926087828,104.8174748427723],[11.33037894807425,104.8156297044021],[11.3286085550757,104.8151678225153]]', location_lat_long: '11.329241703149044, 104.81632133264384', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 756, fruitful_tree: 187, active: true},
  {uuid: '00000000-0000-0000-0000-000000000032', name: 'Block I1', area_id: chamkar_doung_area_i.uuid, surface: 4, shape_lat_long: '[[11.3324022446687,104.8042941445527],[11.33164938030391,104.8065486628382],[11.3334404657311,104.8070589193398],[11.3342676928524,104.8047661083512],[11.3324022446687,104.8042941445527]]', location_lat_long: '11.332958536578154, 104.80567653194635', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1131, fruitful_tree: 178, active: true},
  {uuid: '00000000-0000-0000-0000-000000000033', name: 'Block I2', area_id: chamkar_doung_area_i.uuid, surface: 4, shape_lat_long: '[[11.33492367693084,104.8015384560223],[11.33467951313124,104.8013293103207],[11.33336395165803,104.8014360061919],[11.33242122204219,104.8042657176261],[11.33426388450605,104.804726248476],[11.33536404403283,104.8016738511326],[11.33492367693084,104.8015384560223]]', location_lat_long: '11.33389263303751, 104.80302777939835', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1385, fruitful_tree: 157, active: true},
  {uuid: '00000000-0000-0000-0000-000000000034', name: 'Block I3', area_id: chamkar_doung_area_i.uuid, surface: 4, shape_lat_long: '[[11.33434859381274,104.8047705058938],[11.33350709094434,104.8070525410914],[11.33527396981768,104.8075343705733],[11.33614421459257,104.8052464739713],[11.33434859381274,104.8047705058938]]', location_lat_long: '11.334825652768455, 104.80615243823354', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1131, fruitful_tree: 136, active: true},
  {uuid: '00000000-0000-0000-0000-000000000035', name: 'Block I4', area_id: chamkar_doung_area_i.uuid, surface: 4, shape_lat_long: '[[11.33707418922496,104.8022512736031],[11.3354394902197,104.8017088606098],[11.33436599639989,104.8047216682367],[11.33613371377982,104.8051919475539],[11.33707418922496,104.8022512736031]]', location_lat_long: '11.335720092812426, 104.80345040408179', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1238, fruitful_tree: 128, active: true},
  {uuid: '00000000-0000-0000-0000-000000000036', name: 'Block I5', area_id: chamkar_doung_area_i.uuid, surface: 4, shape_lat_long: '[[11.33617394243781,104.8052424236405],[11.33531690018371,104.8075812926398],[11.33713451662814,104.8080718651833],[11.3379516729193,104.8056830796728],[11.33617394243781,104.8052424236405]]', location_lat_long: '11.336634286551504, 104.80665714441193', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1131, fruitful_tree: 135, active: true},
  {uuid: '00000000-0000-0000-0000-000000000037', name: 'Block I6', area_id: chamkar_doung_area_i.uuid, surface: 4, shape_lat_long: '[[11.33828857294806,104.8036737626171],[11.33833239952572,104.8027955498817],[11.33714283672099,104.8023532391344],[11.33620690295893,104.805217520258],[11.33794729100083,104.8056526567445],[11.33857043886292,104.8037779040884],[11.33828857294806,104.8036737626171]]', location_lat_long: '11.337388670910926, 104.80400294793947', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1450, fruitful_tree: 125, active: true},
  {uuid: '00000000-0000-0000-0000-000000000038', name: 'Block J1', area_id: chamkar_doung_area_j.uuid, surface: 4, shape_lat_long: '[[11.33979325444465,104.8061649455371],[11.33799482066268,104.8057040401415],[11.33716983344916,104.8080579554628],[11.33898506018158,104.8084926218348],[11.33979325444465,104.8061649455371]]', location_lat_long: '11.338481543946905, 104.8070983309882', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1131, fruitful_tree: 120, active: true},
  {uuid: '00000000-0000-0000-0000-000000000039', name: 'Block J2', area_id: chamkar_doung_area_j.uuid, surface: 4, shape_lat_long: '[[11.3386157451609,104.8037694944433],[11.33800553636471,104.805678864691],[11.33980508985562,104.8061342395288],[11.34034560875786,104.8042807549141],[11.3386157451609,104.8037694944433]]', location_lat_long: '11.339175572561285, 104.80495186698602', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 826, fruitful_tree: 134, active: true},
  {uuid: '00000000-0000-0000-0000-000000000040', name: 'Block J3', area_id: chamkar_doung_area_j.uuid, surface: 4, shape_lat_long: '[[11.33982474790186,104.8061663358202],[11.33902478544764,104.8084958607315],[11.34090069335594,104.8089471660317],[11.34163319340202,104.8066899376752],[11.33982474790186,104.8061663358202]]', location_lat_long: '11.34032898942483, 104.80755675092587', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1103, fruitful_tree: 180, active: true},
  {uuid: '00000000-0000-0000-0000-000000000041', name: 'Block J4', area_id: chamkar_doung_area_j.uuid, surface: 4, shape_lat_long: '[[11.34087584637534,104.8050964793755],[11.340352219051,104.8046239253708],[11.33986391779138,104.8061480211514],[11.34164587779042,104.8066585845282],[11.34182634072648,104.8061030939834],[11.34087584637534,104.8050964793755]]', location_lat_long: '11.34084512925893, 104.80564125494948', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 440, fruitful_tree: 164, active: true},
  {uuid: '00000000-0000-0000-0000-000000000042', name: 'Block J5', area_id: chamkar_doung_area_j.uuid, surface: 4, shape_lat_long: '[[11.34186057463051,104.8061028092931],[11.34092174135658,104.8089562777395],[11.34266915872802,104.8094107115371],[11.34319611496048,104.8067220019364],[11.34264431599125,104.8065308463703],[11.3421582951397,104.806287292104],[11.34186057463051,104.8061028092931]]', location_lat_long: '11.34205892815853, 104.80775676041503', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 1146, fruitful_tree: 123, active: true},
  {uuid: '00000000-0000-0000-0000-000000000043', name: 'Block A', area_id: chamkar_doung_jackfruit_area_a.uuid, surface: 4, shape_lat_long: '[[11.3406183375262,104.8220830750786],[11.34048569682613,104.8225603305345],[11.34077415662084,104.8227130665497],[11.34076394170529,104.8228339709717],[11.34123410683447,104.8228804399975],[11.34177497649118,104.8230441480793],[11.34194189011643,104.8223583223038],[11.3406183375262,104.8220830750786]]', location_lat_long: '11.34121379347128, 104.82256361157897', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: coconut_farm.uuid, tree_amount: 238, fruitful_tree: 132, active: true},
  {uuid: '00000000-0000-0000-0000-000000000044', name: 'Block H1', area_id: chamkar_doung_area_h.uuid, surface: 4, shape_lat_long: '[[11.33749864362413,104.8298943514796],[11.33785966908949,104.8302254859392],[11.33815970581653,104.8299538765353],[11.3378398682959,104.8296867865631],[11.33766335361885,104.8297072352362],[11.33749864362413,104.8298943514796]]', location_lat_long: '11.33782917472033, 104.82995613625121', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: otaroit_farm.uuid, tree_amount: 49, fruitful_tree: 143, active: true},
  {uuid: '00000000-0000-0000-0000-000000000045', name: 'Block H2', area_id: chamkar_doung_area_h.uuid, surface: 4, shape_lat_long: '[[11.33646442851698,104.8332979004284],[11.33707189562497,104.8341681729643],[11.33729928279908,104.833936034182],[11.33723323671427,104.8337544618195],[11.33728426248107,104.8335766227944],[11.33745174574079,104.8334014565649],[11.33763647987138,104.8332860329863],[11.33783922656446,104.8333488578761],[11.33804445537022,104.8330248844882],[11.33740804441472,104.8326239709922],[11.33731453853232,104.8324982353813],[11.33646442851698,104.8332979004284]]', location_lat_long: '11.3372544419436, 104.83333320417273', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: otaroit_farm.uuid, tree_amount: 191, fruitful_tree: 165, active: true},
  {uuid: '00000000-0000-0000-0000-000000000046', name: 'Block H3', area_id: chamkar_doung_area_h.uuid, surface: 4, shape_lat_long: '[[11.3372679996426,104.8325059165098],[11.33730791256416,104.8321196711066],[11.3371443150519,104.8320779572096],[11.33716705582465,104.8319301829207],[11.33616371899917,104.8316419076457],[11.33623023692973,104.8312767134095],[11.33630901863554,104.8310646979249],[11.33617351057816,104.8309092790418],[11.33533794890737,104.8316617945741],[11.33645995445173,104.833276482145],[11.3372679996426,104.8325059165098]]', location_lat_long: '11.336322930735765, 104.83209288059345', rental_status: 0, status: 0, planting_project_id: coconut_planting_project.uuid, farm_id: otaroit_farm.uuid, tree_amount: 382, fruitful_tree: 142, active: true},
  {uuid: '00000000-0000-0000-0000-000000000047', name: 'Block C', area_id: kbalsen_area_a.uuid, surface: 4, shape_lat_long: '[[11.33557194760326,104.8573975525616],[11.33558298860871,104.8587322496375],[11.33862087995062,104.858801039787],[11.33844403216365,104.8586081788546],[11.33836139033863,104.8581275633926],[11.33786493936882,104.8573554451791],[11.33710902473094,104.8574518912633],[11.33707836757187,104.8572201042799],[11.33557194760326,104.8573975525616]]', location_lat_long: '11.33709641377694, 104.85801057203344', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: kbalsen_farm.uuid, tree_amount: 900, fruitful_tree: 19, active: true},
  {uuid: '00000000-0000-0000-0000-000000000048', name: 'Block A', area_id: kapet_area_a.uuid, surface: 4, shape_lat_long: '[[11.33777880917669,104.8646448230094],[11.33798296675998,104.862326918342],[11.3370053204312,104.8622471278479],[11.3367965700311,104.8639915327844],[11.33764688542105,104.8640258355994],[11.33768905199083,104.8646228878392],[11.33777880917669,104.8646448230094]]', location_lat_long: '11.33837330655616, 104.8636930508012', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: kapet_farm.uuid, tree_amount: 350, fruitful_tree: 16, active: true},
  {uuid: '00000000-0000-0000-0000-000000000049', name: 'Block B', area_id: kapet_area_b.uuid, surface: 4, shape_lat_long: '[[11.3389182060508,104.8624085032788],[11.33801384688448,104.8623284283133],[11.33782840706152,104.8646737365057],[11.33840840055437,104.8650576732891],[11.33876855426428,104.8650432478133],[11.33882897377334,104.8635461889699],[11.33877691802279,104.8635386373277],[11.33877691987079,104.8634581319374],[11.33883301559102,104.8634345953649],[11.3389182060508,104.8624085032788]]', location_lat_long: '11.33738976839554, 104.8634459754287', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: kapet_farm.uuid, tree_amount: 550, fruitful_tree: 12, active: true},
  {uuid: '00000000-0000-0000-0000-000000000050', name: 'Block A1', area_id: oroung_area_a.uuid, surface: 4, shape_lat_long: '[[11.33311439628769,104.863074517573],[11.33303836909471,104.8645267817349],[11.33419647990755,104.8649847944117],[11.33421414894168,104.8637520663834],[11.33311439628769,104.863074517573]]', location_lat_long: '11.333626259018196, 104.86402965599245', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: oroung_farm.uuid, tree_amount: 318, fruitful_tree: 16, active: true},
  {uuid: '00000000-0000-0000-0000-000000000051', name: 'Block A2', area_id: oroung_area_a.uuid, surface: 4, shape_lat_long: '[[11.3324478315573,104.8626668657542],[11.33237585061472,104.8641630720923],[11.3326473207779,104.864211450934],[11.33269227121635,104.8643861577813],[11.33301753047669,104.8645186365714],[11.33307675273036,104.8630691210814],[11.3324478315573,104.8626668657542]]', location_lat_long: '11.33272630167254, 104.86359275116274', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: oroung_farm.uuid, tree_amount: 123, fruitful_tree: 90, active: true},
  {uuid: '00000000-0000-0000-0000-000000000052', name: 'Block A3', area_id: oroung_area_a.uuid, surface: 4, shape_lat_long: '[[11.33259193166157,104.864971260675],[11.33255103799581,104.8653026157271],[11.33242918270696,104.8653124252415],[11.33241636992461,104.8656656733321],[11.33254475167357,104.8657207093244],[11.33256256387976,104.8659044565683],[11.33293397308591,104.865911430465],[11.33298004181689,104.8650429908266],[11.33259193166157,104.864971260675]]', location_lat_long: '11.33269820587075, 104.86544134557005', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: oroung_farm.uuid, tree_amount: 93, fruitful_tree: 15, active: true},
  {uuid: '00000000-0000-0000-0000-000000000053', name: 'Block B1', area_id: oroung_area_b.uuid, surface: 4, shape_lat_long: '[[11.33360091727752,104.8648150209845],[11.33354905571442,104.8654192999268],[11.3334329480574,104.8653970369069],[11.33344462261639,104.8651619590034],[11.33304147819797,104.8650389585108],[11.33295439699371,104.8665397635701],[11.33419145854843,104.8669987532221],[11.33419096118103,104.8650500301504],[11.33360091727752,104.8648150209845]]', location_lat_long: '11.333572927771069, 104.86590688710328', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: oroung_farm.uuid, tree_amount: 425, fruitful_tree: 132, active: true},
  {uuid: '00000000-0000-0000-0000-000000000054', name: 'Block B2', area_id: oroung_area_b.uuid, surface: 4, shape_lat_long: '[[11.33297236650325,104.8665889012607],[11.33290609918916,104.8681085700067],[11.33318887235587,104.8681464909949],[11.33319890176019,104.8682790524576],[11.33418809491344,104.8682950611748],[11.334192036974,104.8670305625423],[11.33297236650325,104.8665889012607]]', location_lat_long: '11.333549068081581, 104.86744198121778', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: oroung_farm.uuid, tree_amount: 401, fruitful_tree: 18, active: true},
  {uuid: '00000000-0000-0000-0000-000000000055', name: 'Block C1', area_id: oroung_area_c.uuid, surface: 4, shape_lat_long: '[[11.33286716554191,104.8683328834296],[11.33281790971606,104.8710704750993],[11.33378832634235,104.8710829491849],[11.33378833233909,104.8709496668367],[11.33371753280396,104.870900716156],[11.33378844867719,104.868480493603],[11.33414409924556,104.8684593112575],[11.33414926227775,104.8683328873223],[11.33286716554191,104.8683328834296]]', location_lat_long: '11.333483585996905, 104.86970791630733', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: oroung_farm.uuid, tree_amount: 407, fruitful_tree: 17, active: true, fruitful_tree: 12, active: true},
  {uuid: '00000000-0000-0000-0000-000000000056', name: 'Block C2', area_id: oroung_area_c.uuid, surface: 4, shape_lat_long: '[[11.3322750761453,104.8693063700752],[11.33222632314401,104.8708299466653],[11.33250555605274,104.8708585729013],[11.33257165108565,104.8693194724903],[11.3322750761453,104.8693063700752]]', location_lat_long: '11.332398987114829, 104.87008247148833', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: oroung_farm.uuid, tree_amount: 116, fruitful_tree: 13, active: true},
  {uuid: '00000000-0000-0000-0000-000000000057', name: 'Block C3', area_id: oroung_area_c.uuid, surface: 4, shape_lat_long: '[[11.33327767462742,104.8714486012229],[11.33326530072757,104.8722167315754],[11.33389699046733,104.8722127064837],[11.33389957250136,104.871824944219],[11.33373153189838,104.8717984056386],[11.33375157922602,104.8714607584913],[11.33327767462742,104.8714486012229]]', location_lat_long: '11.333582436614465, 104.8718326663992', rental_status: 0, status: 0, planting_project_id: jackfruit_planting_project.uuid, farm_id: oroung_farm.uuid, tree_amount: 54, fruitful_tree: 14, active: true}
].each do |block|
  Block.create_with(name: block[:name], area_id: block[:area_id], surface: block[:surface], shape_lat_long: block[:shape_lat_long], location_lat_long: block[:location_lat_long], rental_status: block[:rental_status], status: block[:status], planting_project_id: block[:planting_project_id], farm_id: block[:farm_id], tree_amount: block[:tree_amount], fruitful_tree: block[:fruitful_tree], active: block[:active]).find_or_create_by(uuid: block[:uuid])
end

# ========== Phase ==========
[
  {name: 'Phase 1: Nursery Seed', note: 'The first phase of planting', active: true},
  {name: 'Phase 2: Plant Growing & Protection', note: 'The second phase of planting', active: true}
].each do |phase|
  Phase.create_with(note: phase[:note]).find_or_create_by(name: phase[:name])
end

# ========== Production Stage ==========
phase = Phase.create_with(note: 'The first phase of planting', active: true).find_or_create_by(name: 'Phase 1: Nursery Seed')
production_stage = ProductionStage.create_with(note: 'The first Stage of planting Coconut', active: true).find_or_create_by(name: 'Stage1: Age 1-2 Years')

phase.production_stages << production_stage

# ========== Production Status ==========
ProductionStatus.create_with(name: 'New Planting', stage_id: production_stage.uuid, note: 'For growing a new tree in a new pit', active: true).find_or_create_by(name: 'New Planting')