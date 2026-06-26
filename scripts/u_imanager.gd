extends CanvasLayer
@onready var barrel_panel =  $Shop
# shopkeeper
@onready var pause_menu = $pauseMenu
# item track popup
#unlock system
var	view_bool = false

var item_count_switch = false
var health_switch = false
var eqipment_switch = false
var log_switch = false
var wisdom_switch= false
var mimimap_switch = false
var wm_switch = false



var magic_upgrade = [GameManager.magic_ice_upgrade,GameManager.magic_earth_upgrade,GameManager.magic_fire_upgrade, GameManager.magic_wind_upgrade]
@onready var player = self.get_parent().get_child(1)
var weapeon_menu_active: int = 1


var fables = ['0','1','2','3']
var seen_folk_wisdom = [0,1,2,3,4,5,6,7,8,9,10]
var seen_fables = [0,1,2,3]
var ws_cost_1 = randi_range(75,200)
var ws_cost_2 = randi_range(75,200)
var ws_cost_3 = randi_range(75,200)


var x_offset = 0
var y_offset = 0
func _ready() :
	match opened_eq_type:
		'meele': meele_equpmet_item_generation()
		'mage': mage_equpmet_item_generation()
		'neck': neck_equpmet_item_generation()
		'food': food_equpmet_item_generation()
	if get_tree().current_scene.name == 'main':
		$Options.hide()
		$ability_icon.hide()

	if GameManager.equiped_staff == 0:
		update_ab_icon(0)
	else:	
		update_ab_icon(GameManager.equiped_staff)
	
	$caje_shop/sell/lacne/Label5/own2.text = str(GameManager.plants['zihlava'])
	$caje_shop/sell/lacne/Label4/own3.text = str(GameManager.plants['cesnak'])
	$caje_shop/sell/lacne/Label3/own4.text = str(GameManager.plants['hluchavka'])
	$caje_shop/sell/lacne/Label2/own5.text = str(GameManager.plants['pupava'])
	$caje_shop/sell/lacne/Label/own6.text = str(GameManager.plants['mata'])
	$caje_shop/sell/stredne/Label7/own.text = str(GameManager.plants['slez'])
	$caje_shop/sell/stredne/Label8/own2.text = str(GameManager.plants['salvia'])
	$caje_shop/sell/stredne/Label9/own3.text = str(GameManager.plants['skorocel'])
	$caje_shop/sell/stredne/Label10/own4.text = str(GameManager.plants['divozel'])
	$caje_shop/sell/vzacne/Label11/own5.text = str(GameManager.plants['alchemilka'])
	$caje_shop/sell/vzacne/Label12/own6.text = str(GameManager.plants['cakanka'])
	$caje_shop/sell/vzacne/Label13/own7.text = str(GameManager.plants['marinka'])
	$caje_shop/sell/vzacne/Label14/own8.text = str(GameManager.plants['nevadza'])
	$caje_shop/sell/vzacne/Label16/own9.text = str(GameManager.plants['prvosienky'])
	$caje_shop/sell/vzacne/Label15/own10.text = str(GameManager.plants['trezalka'])
	$caje_shop/sell/special/Label17/own11.text = str(GameManager.plants['jesienka'])
	$caje_shop/sell/special/Label18/own12.text = str(GameManager.plants['konvalinka'])
	#await  get_tree().create_timer(0.25).timeout
	var opened = GameManager.load_save()[6]
	print(opened)
	if opened:
		if opened[0]:
			item_count_switch = true
		if opened[1]:
			health_switch = true
		if opened[2]:
			eqipment_switch = true
		if opened[3]:
			log_switch = true
		if opened[4]:
			wisdom_switch = true
		if opened[5]:
			mimimap_switch = true
		if opened[6]:
			wm_switch = true
	GameManager.pause_menu = $pauseMenu
	
	update_world_ui(GameManager.current_level_path)

	if GameManager.necklaces_bought[0] == true:
		$Shop/armor_class/ice_a.disabled = true
	if GameManager.necklaces_bought[1] == true:
		$Shop/armor_class/earth_a.disabled = true
	if GameManager.necklaces_bought[2] == true:
		$Shop/armor_class/fire_a.disabled = true
	if GameManager.necklaces_bought[3] == true:
		$Shop/armor_class/wind_a.disabled = true
		
	if GameManager.magic_ice_upgrade >= 3:
		$Shop/magic_class/ice.disabled = true
	if GameManager.magic_earth_upgrade >= 3:
		$Shop/magic_class/earth.disabled = true
	if GameManager.magic_fire_upgrade >= 3:
		$Shop/magic_class/fire.disabled = true
	if GameManager.magic_wind_upgrade >= 3:
		$Shop/magic_class/wind.disabled = true
		
	if GameManager.equiped_staff == 1:
		$equipment/eq_ice_but.button_pressed = true
	if GameManager.equiped_staff == 2:
		$equipment/eq_earth_but.button_pressed = true
	if GameManager.equiped_staff == 3:
		$equipment/eq_fire_but.button_pressed = true
	if GameManager.equiped_staff == 4:
		$equipment/eq_wind_but.button_pressed = true
	
	if GameManager.meele_bought[0] :
		$Shop/meele_class/ice_m.disabled = true
	if GameManager.meele_bought[1] :
		$Shop/meele_class/earth_m.disabled =true
	if GameManager.meele_bought[2] :
		$Shop/meele_class/fire_m.disabled = true
	if GameManager.meele_bought[3]:
		$Shop/meele_class/wind_m.disabled = true
	
	if GameManager.meele_bought[0] == 0:
		$equipment/eq_meele_ice.disabled == true
	if GameManager.meele_bought[1] == 0:
		$equipment/eq_meele_earth.disabled = true
	if GameManager.meele_bought[2] == 0:
		$equipment/eq_meele_fire.disabled = true
	if GameManager.meele_bought[3] == 0:
		$equipment/eq_meele_wind.disabled = true
		
	if GameManager.equiped_meele == 1:
		$equipment/eq_meele_ice.button_pressed = true
	if GameManager.equiped_meele == 2:
		$equipment/eq_meele_earth.button_pressed = true
	if GameManager.equiped_meele == 3:
		$equipment/eq_meele_fire.button_pressed = true
	if GameManager.equiped_meele == 4:
		$equipment/eq_meele_wind.button_pressed = true
		
	if GameManager.equiped_necklace == 1:
		$equipment/eq_necklace_ice.button_pressed = true
	if GameManager.equiped_necklace == 2:
		$equipment/eq_necklace_earth.button_pressed = true
	if GameManager.equiped_necklace == 3:
		$equipment/eq_necklace_fire.button_pressed = true
	if GameManager.equiped_necklace == 4:
		$equipment/eq_necklace_wind.button_pressed = true

	$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
	$Upgrade_wisdom/convert/wisdom_points_counter.text = str(GameManager.wisdom_points)
	
	$Upgrade_wisdom/w_meele_class/A/A_value.text = "A - "+str(GameManager.meele_variables[0])
	$Upgrade_wisdom/w_meele_class/h/h_value.text = 'h - '+str(GameManager.meele_variables[2])
	$Upgrade_wisdom/w_meele_class/sigma/s_value.text = 'sigma - '+str(GameManager.meele_variables[3])
	$Upgrade_wisdom/w_meele_class/F/F_value.text = 'F - '+str(GameManager.meele_variables[1])
	
#	$Upgrade_wisdom/w_magic_class/R/R_value.text = 'R - '+str(GameManager.magic_variables[1])
#	$Upgrade_wisdom/w_magic_class/PD/PD_value.text = 'PD - '+str(GameManager.magic_variables[0])
#	$Upgrade_wisdom/w_magic_class/SPD/SPD_value.text = 'SPD - '+str(GameManager.magic_variables[2])
	
	$Upgrade_wisdom/w_stats_class/w_stats_h/health_value.text = str(GameManager.base_health)
	$Upgrade_wisdom/w_stats_class/w_stats_s/shield_value.text = str(GameManager.base_shield)
	
	$Wisdom_shop/ws_option_1/ws_cost_1.text = 'Cost: '+str(ws_cost_1)
	$Wisdom_shop/ws_option_2/ws_cost_2.text = 'Cost: '+str(ws_cost_2)
	$Wisdom_shop/ws_option_3/ws_cost_3.text = 'Cost: '+str(ws_cost_3)
	
	$Upgrade_wisdom/convert/total_upgrades.text = 'Total upgrades: '+str(GameManager.wisdom_upgrade_level)
	


func _process(delta: float) -> void:
	

	await get_tree().create_timer(0.15).timeout
	if GameManager.magic_ice_upgrade == 0:
		$equipment/eq_ice_but.disabled = true
	else:
		$equipment/eq_ice_but.disabled = false	
	if GameManager.magic_earth_upgrade == 0:
		$equipment/eq_earth_but.disabled = true
	else:
		$equipment/eq_earth_but.disabled = false
	if GameManager.magic_fire_upgrade == 0:
		$equipment/eq_fire_but.disabled = true
	else:
		$equipment/eq_fire_but.disabled = false
	if GameManager.magic_wind_upgrade == 0:
		$equipment/eq_wind_but.disabled = true
	else:
		$equipment/eq_wind_but.disabled = false
		
	if GameManager.necklaces_bought[0]==false:
			$equipment/eq_necklace_ice.disabled = true
	else:
		$equipment/eq_necklace_ice.disabled = false
	if GameManager.necklaces_bought[1]==false:
			$equipment/eq_necklace_earth.disabled = true
	else:
		$equipment/eq_necklace_earth.disabled = false
	if GameManager.necklaces_bought[2] ==false:
			$equipment/eq_necklace_fire.disabled = true
	else:
		$equipment/eq_necklace_fire.disabled = false
	if GameManager.necklaces_bought[3]== false:
			$equipment/eq_necklace_wind.disabled = true
	else:
		$equipment/eq_necklace_wind.disabled = false
	
	if GameManager.meele_bought[0] :
		$Shop/meele_class/ice_m.disabled = true
	if GameManager.meele_bought[1] :
		$Shop/meele_class/earth_m.disabled =true
	if GameManager.meele_bought[2] :
		$Shop/meele_class/fire_m.disabled = true
	if GameManager.meele_bought[3]:
		$Shop/meele_class/wind_m.disabled = true
	
	if GameManager.meele_bought[0] == 0:
		$equipment/eq_meele_ice.disabled = true
	else:
		$equipment/eq_meele_ice.disabled =false
	
		
	if GameManager.meele_bought[1] == 0:
		$equipment/eq_meele_earth.disabled = true
	else:
		$equipment/eq_meele_earth.disabled = false
	if GameManager.meele_bought[2] == 0:
		$equipment/eq_meele_fire.disabled = true
	else:
		$equipment/eq_meele_fire.disabled = false
	if GameManager.meele_bought[3] == 0:
		$equipment/eq_meele_wind.disabled = true
	else:
		$equipment/eq_meele_wind.disabled = false
		
	
func update_coin_display(gained_coins):
	##print(GameManager.coins)
	$CoinDaaisplay.text = str(GameManager.coins)
func _input(event):
	if Input.is_action_just_pressed("pause"):
		GameManager.pause_play()
		get_tree().paused = GameManager.paused
	if Input.is_action_just_pressed("go_to") and view_bool:
		$view.hide()
	#if event is InputEventMouseButton:
		##print(get_viewport().gui_get_focus_owner())
	#get_viewport().set_input_as_handled()
	#if event is InputEventMouseButton and event.pressed:
		#get_viewport().set_input_as_handled()
func _on_resume_pressed() -> void:
	GameManager.resume()

func _on_restart_pressed() -> void:
	GameManager.restart()

func _on_world_map_pressed() -> void:
	GameManager.world_map()

func _on_quit_pressed() -> void:
	GameManager.quit()

func _on_finish_level_pressed() -> void:
	GameManager.load_world()

func _on_close_pressed() -> void:
	$Shop/notenough.hide()
	$Shop.hide()
	
func shop_face(state):
	if state == 0:
		$Shop/Shop_face.texture = preload("res://assets/postavy/predavač0000.png")
	elif state == 1:
		$Shop/Shop_face.texture = preload("res://assets/postavy/predavač0001.png")
	elif state == 2:
		$Shop/Shop_face.texture = preload("res://assets/postavy/predavač0002.png")
func show_barrel_ui():
	$Shop/notenough.hide()
	##print(weapeon_menu_active)
	$Shop.show()
	shop_face(0)
	if weapeon_menu_active == 1:
		$Shop/magic_class.show()
		$Shop/meele_class.hide()
		$Shop/armor_class.hide()
	elif weapeon_menu_active == 2:
		$Shop/meele_class.show()
		$Shop/magic_class.hide()
		$Shop/armor_class.hide()
	elif weapeon_menu_active == 3:
		$Shop/armor_class.show()
		$Shop/magic_class.hide()
		$Shop/meele_class.hide()
func hide_barrel_ui():
	barrel_panel.hide()
			
func not_enough_display(str_item, items,cost):	
	$Shop/notenough.show()
	shop_face(2)
	if GameManager.get(str_item) < items and GameManager.gold < cost:
		$Shop/notenough.text = 'Not enugh '+str_item+' and gold'
	elif GameManager.get(str_item) < items:
		$Shop/notenough.text = 'Not enugh '+str_item
	elif GameManager.gold < cost:
		$Shop/notenough.text = 'Not enugh gold'			
#magic (funguje!)
func _on_ice_pressed() -> void:
	shop_face(1)
	var uppgrade_type = 'magic_ice_upgrade'
	var upgrade = GameManager.get(uppgrade_type)
	var cost 
	var items
	var str_item = 'deepfrost'
	# 1 ice 2 earth 3 fire 4 wind
	var element = 1
	var label = $Shop/magic_class/ice/cena_l
#	var hower = $Shop/magic_class/ice/howertextl
	$Shop/notenough.hide()
	if upgrade == 0:
		cost = 100 
		items = 15
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:
			GameManager.magic_bought[0] = 1
			GameManager.magic_unlocked = true
			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
			GameManager.magic_unlocked = true
			GameManager.equiped_staff = element
			GameManager.magic_bought[element-1] = true
			$Shop/magic_class/ice/ice_mag_upgrade_1.color = 'e6c46d'
#func upgrade_equpiment(upgrade)
		else:
			not_enough_display(str_item,items,cost)
	elif upgrade == 1:
		cost = 300 
		items = 30
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:

			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1

			$Shop/magic_class/ice/ice_mag_upgrade_2.color = 'e6c46d'
			GameManager.equiped_staff = element
		else:
			not_enough_display(str_item,items,cost)
	elif upgrade == 2:
		cost = 500
		items = 100
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:
			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1

			$Shop/magic_class/ice/ice_mag_upgrade_3.color = 'e6c46d'
			GameManager.equiped_staff = element
			$Shop/magic_class/ice.disabled = true
		else:
			not_enough_display(str_item,items,cost)
	else:
		$Shop/notenough.show()
		$Shop/notenough.text = 'max'
			

			

func _on_fire_pressed() -> void:# magic
	var uppgrade_type = 'magic_fire_upgrade'
	var upgrade = GameManager.get(uppgrade_type)
	var cost 
	var items
	var str_item = 'ash'
	# 1 ice 2 earth 3 fire 4 wind
	var element = 3
	var label = $Shop/magic_class/fire/cena_o
#	var hower = $Shop/magic_class/fire/howertextf
	$Shop/notenough.hide()
	if upgrade == 0:
		cost = 100 
		items = 15
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:
			GameManager.magic_bought[2] = 1
			GameManager.magic_unlocked = true
			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
			GameManager.equiped_staff = element
			GameManager.magic_bought[element-1] = true
			$Shop/magic_class/fire/fire_mag_upgrade_1.color = 'e6c46d'
#func upgrade_equpiment(upgrade)
		else:
			not_enough_display(str_item,items,cost)
	elif upgrade == 1:
		cost = 300 
		items = 30
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:

			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
			
			$Shop/magic_class/fire/fire_mag_upgrade_2.color = 'e6c46d'
			GameManager.equiped_staff = element
		else:
			not_enough_display(str_item,items,cost)
	elif upgrade == 2:
		cost = 500
		items = 100
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:

			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
	

			$Shop/magic_class/fire/fire_mag_upgrade_3.color = 'e6c46d'
			GameManager.equiped_staff = element
			$Shop/magic_class/fire.disabled = true
		else:
			not_enough_display(str_item,items,cost)
	else:
		$Shop/notenough.show()
		$Shop/notenough.text = 'max'
func _on_earth_pressed() -> void:
	shop_face(1)
	var uppgrade_type = 'magic_earth_upgrade'
	var upgrade = GameManager.get(uppgrade_type)
	var cost 
	var items
	var str_item = 'livingwood'
	# 1 ice 2 earth 3 fire 4 wind
	var element = 2
	var label = $Shop/magic_class/earth/cena_z
	#var hower = $Shop/magic_class/earth/howertexte
	$Shop/notenough.hide()
	if upgrade == 0:
		cost = 100 
		items = 15
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:
			GameManager.magic_bought[1] = 1
			GameManager.magic_unlocked = true
			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
			GameManager.equiped_staff = element
			GameManager.magic_bought[element-1] = true
			$Shop/magic_class/earth/earth_mag_upgrade_1.color = 'e6c46d'
#func upgrade_equpiment(upgrade)
		else:
			not_enough_display(str_item,items,cost)
	elif upgrade == 1:
		cost = 300 
		items = 30
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:

			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
	

			$Shop/magic_class/earth/earth_mag_upgrade_2.color = 'e6c46d'
			GameManager.equiped_staff = element
		else:
			not_enough_display(str_item,items,cost)
	elif upgrade == 2:
		cost = 500
		items = 100
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:

			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
	
	
			$Shop/magic_class/earth/earth_mag_upgrade_3.color = 'e6c46d'
			GameManager.equiped_staff = element
			$Shop/magic_class/earth.disabled = true
		else:
			not_enough_display(str_item,items,cost)
	else:
		$Shop/notenough.show()
		$Shop/notenough.text = 'max'
		
		
func _on_wind_pressed() -> void:
	shop_face(1)
	var uppgrade_type = 'magic_wind_upgrade'
	var upgrade = GameManager.get(uppgrade_type)
	var cost 
	var items
	var str_item = 'windsteel'
	# 1 ice 2 earth 3 fire 4 wind
	var element = 4
	var label = $Shop/magic_class/wind/cena_w
	#var hower = $Shop/magic_class/wind/howertextw
	$Shop/notenough.hide()
	if upgrade == 0:
		cost = 100 
		items = 15
		
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:
			GameManager.magic_bought[3] = 1
			GameManager.magic_unlocked = true
			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1

			GameManager.equiped_staff = element
			GameManager.magic_bought[element-1] = true
			$Shop/magic_class/wind/wind_mag_upgrade_1.color = 'e6c46d'
#func upgrade_equpiment(upgrade)
		else:
			not_enough_display(str_item,items,cost)
	elif upgrade == 1:
		cost = 300 
		items = 30
		
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:
			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
	
			$Shop/magic_class/wind/wind_mag_upgrade_2.color = 'e6c46d'
			GameManager.equiped_staff = element
		else:
			not_enough_display(str_item,items,cost)
	elif upgrade == 2:
		cost = 500
		items = 100
		if GameManager.get(str_item) >= items  and GameManager.gold >= cost:
	
			GameManager[str_item] -= items
			GameManager.gold -= cost
			GameManager[uppgrade_type] +=1
	

			$Shop/magic_class/wind/wind_mag_upgrade_3.color = 'e6c46d'
			GameManager.equiped_staff = element
			$Shop/magic_class/wind.disabled = true
		else:
			not_enough_display(str_item,items,cost)
	#else:
		#$Shop/notenough.show()
		#$Shop/notenough.text = 'max'
		
#meele
func _on_fire_m_pressed() -> void:
	if GameManager.ash >= 15  and GameManager.gold >= 100:
		GameManager.meele_bought[2] = 1
		GameManager.ash -= 15
		GameManager.gold -= 100
	else:
		$Shop/notenough.show()	
		if GameManager.ash < 15 and GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh ash and gold'
		elif GameManager.ash < 15:
			$Shop/notenough.text = 'Not enugh ash'
		elif GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh gold'
func _on_wind_m_pressed() -> void:
	shop_face(1)
	if GameManager.windsteel >= 15  and GameManager.gold >= 100:
		GameManager.meele_bought[3] = 1
		GameManager.windsteel -= 15
		GameManager.gold -= 100
	else:
		$Shop/notenough.show()
		if GameManager.windsteel < 15 and GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh windsteel and gold'
		elif GameManager.windsteel < 15:
			$Shop/notenough.text = 'Not enugh windsteel'
		elif GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh gold'		
func _on_earth_m_pressed() -> void:
	if GameManager.livingwood >= 15  and GameManager.gold >= 100:
		GameManager.meele_bought[1] = 1
		GameManager.livingwood -= 15
		GameManager.gold -= 100
	else:
		$Shop/notenough.show()	
		if GameManager.livingwood < 15 and GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh living wood and gold'
		elif GameManager.livingwood < 15:
			$Shop/notenough.text = 'Not enugh living wood'
		elif GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh gold'		
func _on_ice_m_pressed() -> void:
	if GameManager.deepfrost >= 15  and GameManager.gold >= 100:
		GameManager.meele_bought[0] = 1
		GameManager.deepfrost -= 15
		GameManager.gold -= 100
	else:
		$Shop/notenough.show()
		if GameManager.deepfrost < 15 and GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh deepfrost and gold'
		elif GameManager.deepfrost < 15:
			$Shop/notenough.text = 'Not enugh deepfrost'
		elif GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh gold'
#armor
func _on_fire_a_pressed() -> void:
	if GameManager.ash >= 15  and GameManager.gold >= 100:
		GameManager.ash -= 15
		GameManager.gold -= 100
		GameManager.necklaces_bought[2] = true
		$Shop/armor_class/fire_a.disabled = true
	else:
		$Shop/notenough.show()	
		if GameManager.ash < 15 and GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh ash and gold'
		elif GameManager.ash < 15:
			$Shop/notenough.text = 'Not enugh ash'
		elif GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh gold'
func _on_wind_a_pressed() -> void :
	if GameManager.windsteel >= 15  and GameManager.gold >= 100:
		GameManager.windsteel -= 15
		GameManager.gold -= 100
		GameManager.necklaces_bought[3] =true
		$Shop/armor_class/wind_a.disabled = true
	else:
		$Shop/notenough.show()
		if GameManager.windsteel < 15 and GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh windsteel and gold'
		elif GameManager.windsteel < 15:
			$Shop/notenough.text = 'Not enugh windsteel'
		elif GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh gold'		
func _on_earth_a_pressed() -> void:
	if GameManager.livingwood >= 15:
		GameManager.livingwood -= 15
		GameManager.gold -= 100
		GameManager.necklaces_bought[1] = true
		$Shop/armor_class/earth_a.disabled = true
	else:
		$Shop/notenough.show()	
		if GameManager.livingwood < 15 and GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh living wood and gold'
		elif GameManager.livingwood < 15:
			$Shop/notenough.text = 'Not enugh living wood'
		elif GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh gold'
func _on_ice_a_pressed() -> void:
	if GameManager.deepfrost >= 15:
		GameManager.deepfrost -= 15
		GameManager.gold -= 100
		GameManager.necklaces_bought[0] = true
		$Shop/armor_class/ice_a.disabled = true
	else:
		$Shop/notenough.show()
		if GameManager.deepfrost < 15 and GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh deepfrost and gold'
		elif GameManager.deepfrost < 15:
			$Shop/notenough.text = 'Not enugh deepfrost'
		elif GameManager.gold < 100:
			$Shop/notenough.text = 'Not enugh gold'	


func _on_meele_2_pressed() -> void:
	weapeon_menu_active = 2
	show_barrel_ui()
func _on_magic_2_pressed() -> void:
	weapeon_menu_active = 1
	show_barrel_ui()
func _on_armor_pressed() -> void:
	weapeon_menu_active = 3
	show_barrel_ui()
	
	


# MAIN MENU
func _on_levels_pressed() -> void:
	GameManager._reset()
	GameManager._save()
	GameManager._load()

	
	get_tree().change_scene_to_file("res://scenes/levely/tutorial.tscn")
	
	
func _on_load_pressed() -> void:
	await get_tree().create_timer(0.02).timeout
	var loaded_data =  GameManager._load()
	#print(loaded_data['level'])
	get_tree().change_scene_to_file(loaded_data['level'])
	#print('after')
func _on_info_pressed() -> void:
	$infotext.show()
	$MainMenu/quit.hide()
	$MainMenu/info.hide()
	$MainMenu/new.hide()
	$MainMenu/load.hide()
func _on_return_pressed() -> void:
	$infotext.hide()
	$MainMenu/quit.show()
	$MainMenu/info.show()
	$MainMenu/new.show()
	$MainMenu/load.show()
	
func _on_respawn_pressed() -> void:
	GameManager.respawn_player(get_tree().current_scene.scene_file_path)
	
func _on_base_pressed() -> void:
	GameManager.player_spawn = 107
	GameManager.respawn_player("res://scenes/levely/drotaverin.tscn")
func _on_texture_button_pressed() -> void:
	update_items_ui()
	item_count_switch = !item_count_switch
	if item_count_switch:
		$ItemCount.show()
	else:
		$ItemCount.hide()
	await get_tree().create_timer(0.1).timeout
	$Options/HBoxContainer/item_button.release_focus()
	
var item_C = preload("res://scenes/UI/item_c.tscn")
var item_C_names_i = ['crystal ice','giant snowflake','frozen core']
var item_C_names_e = ['dense wood','special eaves','strange fruit']
var item_C_names_f = ['magic ash', 'fire in bottle','magma']
var item_C_names_w = [ 'wind feather','wind in bottle','wind metal']
var item_C_count_i = [0,0,0]
var item_C_count_e = [0,0,0]
var item_C_count_f = [0,0,0]
var item_C_count_w = [0,0,0]
var item_C_pic_i = [preload("res://assets/UI/itemy/crystal_ice.png"), preload("res://assets/UI/itemy/giant_snowflake.png"), preload("res://assets/UI/itemy/frozen_core.png")]
var item_C_pic_e = [preload("res://assets/UI/itemy/dense_wood.png"), preload("res://assets/UI/itemy/special_leaves.png"), preload("res://assets/UI/itemy/strange_fruit.png")]
var item_C_pic_f = [preload("res://assets/UI/itemy/magic_ash.png"), preload("res://assets/UI/itemy/fire_in_bottle.png"), preload("res://assets/UI/itemy/magma.png")]
var item_C_pic_w = [preload("res://assets/UI/itemy/wind_feather.png"), preload("res://assets/UI/itemy/wind_in_bottle.png"), preload("res://assets/UI/itemy/wind_metal.png")]
var item_money_pic = preload("res://assets/UI/itemy/money.png")
var item_bar_pic = [preload("res://assets/UI/itemy/silver_bar.png"), preload("res://assets/UI/itemy/iron_bar.png"), preload("res://assets/UI/itemy/antimonite_bar.png"), preload("res://assets/UI/itemy/silver_bar.png"), preload("res://assets/UI/itemy/gold_bar.png")]
var item_solutions_names = ['purified water','alcohol','oil']
var item_solutions_pic = [preload("res://assets/UI/items/item_voda.png"),preload("res://assets/UI/items/alcohol.png"),preload("res://assets/UI/items/item_olej.png")]

var item_bar_names = ['aluminium bar','iron bar','antimonoite bar','silver bar','gold bar']

func update_items_ui():
	item_C_count_i = GameManager.drop_ice
	item_C_count_e = GameManager.drop_earth
	item_C_count_f = GameManager.drop_fire
	item_C_count_w = GameManager.drop_wind
	
	
	if $ItemCount/ScrollContainer/GridContainer.get_children():
		for child in $ItemCount/ScrollContainer/GridContainer.get_children():
			child.queue_free()
			
	await get_tree().process_frame
	await get_tree().process_frame
	
	
	if GameManager.gold:
		var slot = item_C.instantiate()
		slot.get_node('item_C_name').text = 'money'
		slot.get_node('item_C_count').text = str(GameManager.gold)
		slot.get_node('item_C_pic').texture = item_money_pic
		$ItemCount/ScrollContainer/GridContainer.add_child(slot)
	var solutions_count = GameManager.solution
	for i in range(len(solutions_count)):
		if solutions_count[i]:		
			var slot = item_C.instantiate()
			slot.get_node('item_C_name').text = item_solutions_names[i]
			slot.get_node('item_C_count').text = str(solutions_count[i])
			slot.get_node('item_C_pic').texture = item_solutions_pic[i]
			$ItemCount/ScrollContainer/GridContainer.add_child(slot)
	var item_bar_count = GameManager.smelted_bars
	for i in range(len(item_bar_count)):
		if item_bar_count[i]:		
			var slot = item_C.instantiate()
			slot.get_node('item_C_name').text = item_bar_names[i]
			slot.get_node('item_C_count').text = str(item_bar_count[i])
			slot.get_node('item_C_pic').texture = item_bar_pic[i]
			$ItemCount/ScrollContainer/GridContainer.add_child(slot)
	
	
	for i in range(len(item_C_count_i)):
		if item_C_count_i[i]:		
			var slot = item_C.instantiate()
			slot.get_node('item_C_name').text = item_C_names_i[i]
			slot.get_node('item_C_count').text = str(item_C_count_i[i])
			slot.get_node('item_C_pic').texture = item_C_pic_i[i]
			$ItemCount/ScrollContainer/GridContainer.add_child(slot)
	for i in range(len(item_C_count_e)):
		if item_C_count_e[i]:		
			var slot = item_C.instantiate()
			slot.get_node('item_C_name').text = item_C_names_e[i]
			slot.get_node('item_C_count').text = str(item_C_count_e[i])
			slot.get_node('item_C_pic').texture = item_C_pic_e[i]
			$ItemCount/ScrollContainer/GridContainer.add_child(slot)
	for i in range(len(item_C_count_f)):
		if item_C_count_f[i]:		
			var slot = item_C.instantiate()
			slot.get_node('item_C_name').text = item_C_names_f[i]
			slot.get_node('item_C_count').text = str(item_C_count_f[i])
			slot.get_node('item_C_pic').texture = item_C_pic_f[i]
			$ItemCount/ScrollContainer/GridContainer.add_child(slot)
	for i in range(len(item_C_count_w)):
		if item_C_count_w[i]:		
			var slot = item_C.instantiate()
			slot.get_node('item_C_name').text = item_C_names_w[i]
			slot.get_node('item_C_count').text = str(item_C_count_w[i])
			slot.get_node('item_C_pic').texture = item_C_pic_w[i]
			$ItemCount/ScrollContainer/GridContainer.add_child(slot)
			
			
			
var plant_names = ['mata','salvia','divozel','slez','mak','skorocel','pupava','nevadza','cakanka','hluchavka','alchemilka','zihlava','trezalka','marinka','prvosienky','cesnak','konvalinka','jesienka']
var plant_textures = [
	preload("res://assets/decoration/bylinky/mata/mata_1.png"),
	preload("res://assets/decoration/bylinky/salvia/salvia_1.png"),
	preload("res://assets/decoration/bylinky/divozel/divozel_1.png"),
	preload("res://assets/decoration/bylinky/slez/slez_1.png"),
	preload("res://assets/decoration/bylinky/mak/mak_1.png"),
	preload("res://assets/decoration/bylinky/skorocel/skorocel_1.png"),
	preload("res://assets/decoration/bylinky/pupava/pupava_1.png"),
	preload("res://assets/decoration/bylinky/nevadza/nevadza_1.png"),
	preload("res://assets/decoration/bylinky/cakanka/cakanka_1.png"),
	preload("res://assets/decoration/bylinky/hluchavka/hluchavka_1.png"),
	preload("res://assets/decoration/bylinky/alchemilka/alchemilka_1.png"),
	preload("res://assets/decoration/bylinky/zihlava/zihlava_1.png"),
	preload("res://assets/decoration/bylinky/trezalka/trezalka_1.png"),
	preload("res://assets/decoration/bylinky/marinka/marinka_1.png"),
	preload("res://assets/decoration/bylinky/prvosienka/prvosienka_1.png"),
	preload("res://assets/decoration/bylinky/cesnak/cesnak_1.png"),
	preload("res://assets/decoration/bylinky/konvalinka/konvalinka_1.png"),
	preload("res://assets/decoration/bylinky/jesienka/jesienka_1.png"),
]
func update_plants_count_ui():
	if $ItemCount/ScrollContainer/GridContainer.get_children():
		for child in $ItemCount/ScrollContainer/GridContainer.get_children():
			child.queue_free()
			
	await get_tree().process_frame
	await get_tree().process_frame
	var i = 0
	var plant_count = GameManager.plants
	for plant in plant_names:
		if plant_count[plant]:		
			var slot = item_C.instantiate()
			slot.get_node('item_C_name').text = plant
			slot.get_node('item_C_count').text = str(plant_count[plant])
			slot.get_node('item_C_pic').texture = plant_textures[i]
			$ItemCount/ScrollContainer/GridContainer.add_child(slot)
		i += 1
var item_stone_textures = [
	preload("res://assets/decoration/sutre/bauxit/bauxit_1.png"),
	preload("res://assets/decoration/sutre/hematite/hematite_1.png"),
	preload("res://assets/decoration/sutre/malachite/malachite_1.png"),
	preload("res://assets/decoration/sutre/azurite/azurite_1.png"),
	preload("res://assets/decoration/sutre/antimonite/antimonite_1.png"),
	preload("res://assets/decoration/sutre/gold/gold_1.png"),
	preload("res://assets/decoration/sutre/silver/silver_1.png"),
	preload("res://assets/decoration/sutre/zincite/zincite_1.png"),
	preload("res://assets/decoration/sutre/uvarovite/uvarovite_1.png"),
	preload("res://assets/decoration/sutre/opal/opal_1.png"),
]
var item_stone_names = ["bauxit","hematite","malachite","azurite","antimonite","gold","silver","zincite","uvarovite","opal"]

func update_ore_count_ui():
	if $ItemCount/ScrollContainer/GridContainer.get_children():
		for child in $ItemCount/ScrollContainer/GridContainer.get_children():
			child.queue_free()
	var i = 0
	var item_stone_count = GameManager.sutre
	for suter in item_stone_count:
		if item_stone_count[suter]:		
			var slot = item_C.instantiate()
			slot.get_node('item_C_name').text = suter
			slot.get_node('item_C_count').text = str(item_stone_count[suter])
			slot.get_node('item_C_pic').texture = item_stone_textures[i]
			$ItemCount/ScrollContainer/GridContainer.add_child(slot)
		i += 1
func _on_ic_plants_button_pressed() -> void:
	update_plants_count_ui()
func _on_ic_items_button_pressed() -> void:
	update_items_ui()
func _on_ic_ore_button_pressed() -> void:
	update_ore_count_ui()

	
	
	
	
func _on_health_button_pressed() -> void:

	health_switch = !health_switch
	##print(health_switch)
	if health_switch:
		$health_ui.show()
	else:
		$health_ui.hide()
	await get_tree().create_timer(0.1).timeout
	$Options/HBoxContainer/health_button.release_focus()
var opened_eq_type = 'meele'
var eq_idex_selected = null
var item_position = Vector2(15,0)
var item_slot = preload("res://scenes/UI/item.tscn")


var swords_items_names = [' ľadový meč','zemový meč','horuci meč', 'veterný meč','charger','slow down']
var swords_items_icons = [preload("res://assets/mec/icesword.png"),preload("res://assets/mec/earthsword.png"),preload("res://assets/mec/firesword.png"),preload("res://assets/mec/windsword.png"), preload("res://assets/mec/charge_sword.png"),
preload("res://assets/mec/slow_down_sword.png")]
var meele_eq_description = ['blocks magic','passivny regen','veky dmg bonus ale dava dmg stitim, ako po masle','3 bolt strike','passive: can charge infinately but doing so consumes health','charging is more powerful but slows downd']
func _on_eqipiment_button_pressed() -> void:

	eqipment_switch = !eqipment_switch
	if eqipment_switch:
		$equipment2.show()
		
	else:
		$equipment2.hide()
	await get_tree().create_timer(0.1).timeout
	$Options/HBoxContainer/eqipiment_button.release_focus()
	meele_equpmet_item_generation()
	
	
func _on_equip_button_pressed() -> void:
	if eq_idex_selected:
		match opened_eq_type:
			
			'meele':
				#print(eq_idex_selected)
				player.meele_weapeon_equip(eq_idex_selected)
				GameManager.equiped_meele = eq_idex_selected
			'mage':
				#print('ui mage equip ' , eq_idex_selected)
				player.magic_weapeon_equip( eq_idex_selected)
				GameManager.equiped_staff = eq_idex_selected
			'neck':
				#print(eq_idex_selected)
				player.neckleace_equip( eq_idex_selected)
				GameManager.equiped_necklace = eq_idex_selected	
				
func _on_deequip_button_pressed() -> void:
	if eq_idex_selected:
		match opened_eq_type:
			'meele':
				player.meele_weapeon_equip(0)
				GameManager.equiped_meele = 0
			'mage':
				#print('ui mage equip ' , 0)
				player.magic_weapeon_equip( 0)
				GameManager.equiped_staff = 0
			'neck':
				#print(eq_idex_selected)
				player.neckleace_equip( 0)
				GameManager.equiped_necklace = 0	
				

func meele_equpmet_item_generation():
	if $equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
		for child in$equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
			child.queue_free()

	for i in range(len(GameManager.meele_bought)):
		if GameManager.meele_bought[i] :
			##print(i,swords_items_icons[i])
			var slot = item_slot.instantiate()
			slot.position = item_position
			
			slot.get_node('item_name').text = swords_items_names[i]
			slot.get_node('item_picture').texture = swords_items_icons[i]
			#item_position += Vector2(0,100)
			slot.get_node("item_buton").pressed.connect(func(): _on_item_pressed_meele_eq(i))
			$equipment2/ScrollContainer/MarginContainer/GridContainer.add_child(slot)

	
#	item_position = Vector2(15,0)

func _on_item_pressed_meele_eq(i):
	$equipment2/eq_description.text = meele_eq_description[i]
	eq_idex_selected = i+1
var mage_items_names = [' ľadová','zemová','rapid fire rate', 'pen','piercer','teleport','AoE']
var mage_items_icons = [preload("res://assets/player/staffs/staff4.png"),preload("res://assets/player/staffs/staff8.png"),preload("res://assets/player/staffs/staff5.png"), preload("res://assets/player/staffs/staff2.png"),preload("res://assets/player/staffs/staff3.png"),preload("res://assets/player/staffs/staff1.png"),preload("res://assets/player/staffs/staff6.png")]
var mage_eq_description = ['ability: shield, projectiles deal 50% less damage','ability: fullheal','ability: rapid fire','ability: shield pen','passive: pierce','ability: teleports','Ability: AoE']

func mage_equpmet_item_generation():
	if$equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
		for child in$equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
			child.queue_free()
	
	for i in range(len(GameManager.magic_bought)):
		if GameManager.magic_bought[i] :
			##print(i,swords_items_icons[i])
			var slot = item_slot.instantiate()
			#slot.position = item_position
			
			slot.get_node('item_name').text = mage_items_names[i]
			slot.get_node('item_picture').texture = mage_items_icons[i]
			#item_position += Vector2(0,100)
			slot.get_node("item_buton").pressed.connect(func(): _on_item_pressed_magic_eq(i))
			$equipment2/ScrollContainer/MarginContainer/GridContainer.add_child(slot)

	
	#item_position = Vector2(15,0)

func _on_item_pressed_magic_eq(i):
	$equipment2/eq_description.text = mage_eq_description[i]
	eq_idex_selected = i+1
	
	
	
var neck_items_names = [' ľadová','zemová','ohniva', 'veterová',' invis',' invincible',' perfection', 'air damage','']
var neck_items_icons = [preload("res://assets/player/necklaces/necklaceshopitem - ice.png"),preload("res://assets/player/necklaces/necklaceshopitem - earth.png"),preload("res://assets/player/necklaces/necklaceshopitem - fire.png"), preload("res://assets/player/necklaces/necklaceshopitem - wind.png"),
preload("res://assets/player/necklaces/necklaceshopitem - ice gold.png"),preload("res://assets/player/necklaces/necklaceshopitem - earth gold.png"),preload("res://assets/player/necklaces/necklaceshopitem - fire gold.png"),preload("res://assets/player/necklaces/necklaceshopitem - wind gold.png"),preload("res://assets/player/necklaces/necklaceshopitem - wind gold.png")]


var neck_eq_description = ['50% food shd','50% food hp','50% food magic damage','50% food meele A and F','invisibility','short invincibility when health below 20%','increased damage when above 90% hp','40% food meele A and F',''] 

func neck_equpmet_item_generation():
	if$equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
		for child in $equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
			child.queue_free()
	await get_tree().process_frame 
	for i in range(len(GameManager.necklaces_bought)):
		if GameManager.necklaces_bought[i] :
			##print(i,swords_items_icons[i])
			var slot = item_slot.instantiate()
			#slot.position = item_position
			$equipment2/ScrollContainer/MarginContainer/GridContainer
			slot.get_node('item_name').text = neck_items_names[i]
			slot.get_node('item_picture').texture = neck_items_icons[i]
			#item_position += Vector2(0,100)
			slot.get_node("item_buton").pressed.connect(func(): _on_item_pressed_neck_eq(i))
			$equipment2/ScrollContainer/MarginContainer/GridContainer.add_child(slot)

	#for child in $equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
		##print(child.name, " size: ", child.size)

func _on_item_pressed_neck_eq(i):
	$equipment2/eq_description.text = neck_eq_description[i]
	eq_idex_selected = i+1
	
var food_items_names = [' polovica grilovaného kučaťa','ryža','kaleráb', 'ovosné vločky','koleno','mlieko','jogurt', 'neúdená parenica','údená parenica']
var food_items_icons =[preload("res://assets/UI/food/chicken_half.png"), preload("res://assets/UI/food/ryza.png"),preload("res://assets/UI/food/kalerab.png") ,preload("res://assets/UI/food/ovosné_vločky.png"),preload('res://assets/UI/food/koleno.png'),
preload("res://assets/UI/food/milk.png"),preload('res://assets/UI/food/yogurt.png'),preload('res://assets/UI/food/neudena_parenica.png'),preload("res://assets/UI/food/udena_parenica.png")]
var food_eq_description = ['50 HP','100 SHD','3 A','2 P','50 HP', '100 SHD','3 P','5 A ','3 F'] 

var caje_items_names = ['ukludnujúci','priedušky','detox', 'povzbudenie']
var caje_items_icons =[preload("res://assets/UI/food/caj_uk.png"), preload("res://assets/UI/food/caj_dych.png"),preload("res://assets/UI/food/caj_det.png") ,preload("res://assets/UI/food/caj_poz.png")]
var caje_eq_description = ['75 HP','200 SHD','5 A, 5 F','5 P'] 
var fo_ca = 0
func food_equpmet_item_generation():
	if$equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
		for child in $equipment2/ScrollContainer/MarginContainer/GridContainer.get_children():
			child.queue_free()
	await get_tree().process_frame
	await get_tree().process_frame
	for i in range(len(GameManager.food_bought)):
		if GameManager.food_bought[i] :
			##print(i,swords_items_icons[i])
			var slot = item_slot.instantiate()
			#slot.position = item_position
			slot.get_node('item_name').text = food_items_names[i]
			slot.get_node('item_picture').texture = food_items_icons[i]
		#	item_position += Vector2(0,100)
			slot.get_node("item_buton").pressed.connect(func(): _on_item_pressed_food_eq(i))
			$equipment2/ScrollContainer/MarginContainer/GridContainer.add_child(slot)
	
	for i in range(len(GameManager.caje)):
		if GameManager.caje[i] :
			##print(i,swords_items_icons[i])
			var slot = item_slot.instantiate()
		#	slot.position = item_position
			slot.get_node('item_name').text = caje_items_names[i]
			slot.get_node('item_picture').texture = caje_items_icons[i]
	#		item_position += Vector2(0,100)
			slot.get_node("item_buton").pressed.connect(func(): _on_item_pressed_caje_eq(i))
			$equipment2/ScrollContainer/MarginContainer/GridContainer.add_child(slot)
	
	#await get_tree().process_frame
	##print("slots in grid: ", $equipment2/ScrollContainer/MarginContainer/GridContainer.get_child_count())
	
	
	
	
	#item_position = Vector2(15,0)

	
func _on_item_pressed_food_eq(i):
		var p = get_parent().get_node('Player')
		$equipment2/eq_description.text ='All food bonuses are added together.\n HP '+str(p.update_food_hp())+'\n SHD '+str(p.update_food_shd())+'\n P '+str(p.update_food_kuz())+ '\n A '+str(p.update_food_me_A())+'\n F '+str(p.update_food_me_F())+' \n selected gives '+ food_eq_description[i]
		eq_idex_selected = null
	
func _on_item_pressed_caje_eq(i):
		var p = get_parent().get_node('Player')
		$equipment2/eq_description.text ='All food bonuses are added together.\n HP '+str(p.update_food_hp())+'\n SHD '+str(p.update_food_shd())+'\n P '+str(p.update_food_kuz())+ '\n A '+str(p.update_food_me_A())+'\n F '+str(p.update_food_me_F())+' \n selected gives '+ caje_eq_description[i]
		eq_idex_selected = null
	
	
	
	
	
	
	
	
	
	
	
	
	
	
func _on_eq_meele_buton_pressed() -> void:
	opened_eq_type = 'meele'
	meele_equpmet_item_generation()
func _on_eq_mage_buton_pressed() -> void:
	opened_eq_type = 'mage'
	mage_equpmet_item_generation()
func _on_eq_neck_buton_pressed() -> void:
	opened_eq_type = 'neck'
	neck_equpmet_item_generation()
func _on_eq_food_buton_pressed() -> void:
	opened_eq_type = 'food'
	food_equpmet_item_generation()
	
	
	
	
	
	
	
	
func _on_eq_wind_but_pressed() -> void:
	##print(GameManager.magic_wind_upgrade)
	if 	GameManager.magic_wind_upgrade != 0:
		GameManager.equiped_staff = 4
		
		GameManager.magic_unlocked = true
		player.magic_weapeon_equip(4)
		update_ab_icon(4)
		$equipment/not_bought.hide()
	else:
		$equipment/not_bought.show()
func _on_eq_fire_but_pressed() -> void:
	if GameManager.magic_fire_upgrade != 0:
		GameManager.equiped_staff = 3
		update_ab_icon(3)
		GameManager.magic_unlocked = true
		player.magic_weapeon_equip(3)
		
		$equipment/not_bought.hide()
	else:
		$equipment/not_bought.show()
func _on_eq_earth_but_pressed() -> void:
	if GameManager.magic_earth_upgrade != 0:
		GameManager.equiped_staff = 2
		
		update_ab_icon(2)
		GameManager.magic_unlocked = true
		player.magic_weapeon_equip(2)

		$equipment/not_bought.hide()
	else:
		$equipment/not_bought.show()
func _on_eq_ice_but_pressed() -> void:
	if GameManager.magic_ice_upgrade != 0:
		GameManager.equiped_staff = 1

		GameManager.magic_unlocked = true
		player.magic_weapeon_equip(1)
		update_ab_icon(1)
		$equipment/not_bought.hide()
	else:
		$equipment/not_bought.show()
		

func _on_eq_none_staff_but_pressed() -> void:
		GameManager.equiped_staff = 0
	
		GameManager.magic_unlocked = false
		player.magic_weapeon_equip(0)
		update_ab_icon(0)
		
func update_log_info(info):
	$log/log_text.text += '\n'
	$log/log_text.text += info
	$log/log_text.scroll_to_line($log/log_text.get_line_count())
func _on_log_pressed() -> void:
	
	log_switch = !log_switch
	if log_switch:
		$log.show()
	else:
		$log.hide()
	await get_tree().create_timer(0.1).timeout
	$Options/HBoxContainer/log_button.release_focus()


func _on_pause_button_pressed() -> void:
	
	GameManager.pause_play()
	get_tree().paused = GameManager.paused
	await get_tree().create_timer(0.1).timeout
	$Options/HBoxContainer/pause_button.release_focus()
	

func qkt_face(state):
	if state == 0:
		$quest_kill_tree/qkt_face.texture = preload("res://assets/postavy/dievca0000.png")
	elif state == 1:
		$quest_kill_tree/qkt_face.texture = preload("res://assets/postavy/dievca0001.png")
	elif state == 2:
		$quest_kill_tree/qkt_face.texture = preload("res://assets/postavy/dievca0002.png")
	elif state == 3:
		$quest_kill_tree/qkt_face.texture = preload("res://assets/postavy/dievca0003.png")

func _on_qkt_yes_pressed() -> void:
	qkt_face(3)
	$quest_kill_tree/qkt_text.text = "Thank you"
	$quest_kill_tree/qkt_face/qkt_yes.hide()
	$quest_kill_tree/qkt_face/qkt_no.hide()
	$quest_kill_tree/qkt_close.show()
var no = 0
func _on_qkt_no_pressed() -> void:
	no += 1
	if no == 1:
		$quest_kill_tree/qkt_text.text = "That tree must die"
		
		qkt_face(1)
	elif no == 2:
		qkt_face(2)
		$quest_kill_tree/qkt_text.text = "I know trees are lungs of earth, but please, that one must die"
		$quest_kill_tree/qkt_close.hide()
		$quest_kill_tree/qkt_face/qkt_no.hide()
func _on_button_pressed() -> void:
	$quest_kill_tree.hide()
func qkt_begin():
	no = 0
	$quest_kill_tree.show()
	$quest_kill_tree/qkt_text.text = "Help, please!"
	qkt_face(0)
	$quest_kill_tree/qkt_face/qkt_yes.show()
	$quest_kill_tree/qkt_face/qkt_no.show()


		
	# exchange buy	
func _on_ex_ash_but_pressed() -> void:
	if GameManager.gold > 100:
		GameManager.ash += 10
		GameManager.gold -= 100
func _on_ex_df_but_pressed() -> void:
	if GameManager.gold > 100:
		GameManager.deepfrost += 10
		GameManager.gold -= 100
func _on_ex_ws_but_pressed() -> void:
	if GameManager.gold > 100:
		GameManager.windsteel += 10
		GameManager.gold -= 100
func _on_ex_lw_but_pressed() -> void:
	if GameManager.gold > 100:
		GameManager.livingwood += 10
		GameManager.gold -= 100
	#exchange sell
func _on_ex_buy_pressed() -> void:
	$exchange/ex_buy_class.show()
	$exchange/ex_sell_class.hide()

func _on_ex_sell_pressed() -> void:
	$exchange/ex_buy_class.hide()
	$exchange/ex_sell_class.show()
	
func _on_ex_lw_but_sell_pressed() -> void:
	if GameManager.livingwood > 10:
		GameManager.livingwood -= 10
		GameManager.gold += 75

func _on_ex_ws_but_sell_pressed() -> void:
	if GameManager.windsteel > 10:
		GameManager.windsteel -= 10
		GameManager.gold += 75

func _on_ex_df_but_sell_pressed() -> void:
	if GameManager.deepfrost > 10:
		GameManager.deepfrost -= 10
		GameManager.gold += 75

func _on_ex_ash_but_sell_pressed() -> void:
	if GameManager.ash > 10:
		GameManager.ash -= 10
		GameManager.gold += 75
	
func exchange():
	$exchange.show()
func _on_ex_close_pressed() -> void:
	$exchange.hide()
var path
var cutscene_type
var cutscene_length # determines when reset
var current_cutscene
var tutorial_cutscene = [preload("res://assets/pozadie/custcene_tutorial.png"), preload("res://assets/pozadie/cutscene_tutorial2.png")]
var current_type
func level_transition_cutscene(path_to_level, slide, type):
	if type == 0:
		current_cutscene = tutorial_cutscene
		current_type = type
	cutscene_length = len(current_cutscene)
	cutscene_type = 1
	
	$Options.hide()
	$cutscene_background.show()
	GameManager.pause_play()
	get_tree().paused = GameManager.paused
	path = path_to_level
	if slide < cutscene_length:
		#print( slide, cutscene_length)
		$cutscene_background/cutscene.texture = current_cutscene[slide]
	elif slide >= cutscene_length:
		$Options.show()
		$cutscene_background.hide()
		GameManager.resume()
		count = 0
		GameManager.enter_level(path_to_level)
	##print(slide)
func cutscene(slide):
	cutscene_type = 0
	$Options.hide()
	$cutscene_background.show()
	GameManager.pause_play()
	get_tree().paused = GameManager.paused
	#if slide == 1:
		#$cutscene_background/cutscene.texture = preload("res://assets/trees/vstrom/lesne_mesto/budova1.png")
	#elif slide == 2:
		#$cutscene_background/cutscene.texture = preload("res://assets/trees/vstrom/lesne_mesto/budova3.png")

var count = 0
func _on_cuscene_advance_pressed() -> void:
	count +=1
	if cutscene_type == 1:
		level_transition_cutscene(path,count, current_type)
	elif cutscene_type == 0:
		cutscene(count)
		


func wisdom_lockdown(type,points):
	
	$Wisdom_shop.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var selected_wisdom
	var count 
	var wisdom_text
	if type == 'folk':
		selected_wisdom = GameManager.folk_wisdom
		count = GameManager.folk_count
	elif type == 'reg':
		selected_wisdom = GameManager.reg_wisdom
		count = GameManager.reg_count
	elif type == 'oth':
		selected_wisdom = GameManager.oth_wisdom
		count = GameManager.oth_count
	elif type == 'fab':
		selected_wisdom = GameManager.fab_wisdom
		count = GameManager.fab_count
	
	var index = randi_range(0, selected_wisdom.size() - 1)
	
	wisdom_text = selected_wisdom[index]
	while true:	
		#print(count)
		if not 0 in count:
			#print('all used')
			wisdom_text = 'how did this happen, no more elements'
			points = -GameManager.wisdom_points
			break
		if count[index] == 0:
			wisdom_text = selected_wisdom[index]
			GameManager.register_count(type,index)
			break
		elif count[index] == 1:
			index = randi_range(0, selected_wisdom.size() - 1)
	
	
	
	
	
	$wisdom_lockdown.show()
	GameManager.pause_play()
	get_tree().paused = GameManager.paused
	$wisdom_lockdown/wisdom_text.text = wisdom_text
	$wisdom_lockdown/close_wisdom.hide()
	await get_tree().create_timer(5).timeout
	$wisdom_lockdown/close_wisdom.show()
	
	GameManager.wisdom_points +=   round(points)
	update_log_info('Gained '+str(points)+ ' points')
	$Upgrade_wisdom/convert/wisdom_points_counter.text = str(GameManager.wisdom_points)
func _on_close_wisdom_pressed() -> void:
	$wisdom_lockdown.hide()
	GameManager.resume()
	$Wisdom_shop.mouse_filter = Control.MOUSE_FILTER_STOP

func conversation_player(face, text):
	pass
	# to universaly play conversations

func gate_guard_init():
	$conversation.show()
	var gate_guard_face = [preload("res://assets/postavy/gate_guard_face.png")]
	var gate_guard_talk = ['Can I see your papers?']
	var gate_guard_face_order = [0,0]
	var gate_guard_conversation_length = 2

	current_conversation =gate_guard_talk
	current_faces = gate_guard_face
	current_conversation_length = gate_guard_conversation_length
	current_face_order = gate_guard_face_order
	if GameManager.papers == true:
		current_conversation.append('Okay, here you go.')
	else:
		current_conversation.append('Leave or I throw you to the right.')
	konverzácia(0)	
	
	
var smugler_face = [preload('res://assets/postavy/smugler_face_1.png')]
var smugler_talk = ['Hello, i would need something, would you help me?',
'Very well, i need to smuggle certain item to the city on tree. What do you say?',
'Good, here is the package. I guess they will not let you thrug gate, but I think, maybe thrugh crust you culd find a way',
'Find a way around.']
var smugler_face_order = [0,0,0,0]
var smugler_conversation_length = 4
func smugler_init():
	$conversation.show()
	current_conversation =smugler_talk
	current_faces = smugler_face
	current_conversation_length = smugler_conversation_length
	current_face_order = smugler_face_order
	konverzácia(0)	#$smuggler.show()
	#$smuggler/smuggler_text.text= 'Hello, i would need something, would you help me?'

func smugler_end_init():
	var smugler_end_face = [preload("res://assets/postavy/smugler_end_face.png")]
	var smugler_end_talk = ['Hello',
	'What a weather, so windy this high.',
	'You have what i look for?'
	]
	var smugler_end_face_order = [0,0,0,0]
	var smugler_end_conversation_length = 4
	
	
	$conversation.show()
	current_conversation =smugler_end_talk
	current_faces = smugler_end_face
	current_conversation_length = smugler_end_conversation_length
	current_face_order = smugler_end_face_order
	if GameManager.package:
		current_conversation.append('great, take this as my appreciation.')
	elif  current_faces == [preload("res://assets/postavy/smugler_end_face.png")] and GameManager.package == false:
		current_conversation.append('Well than have a day')
		
	konverzácia(0)
	# it is something stupid that is not contrabant normaly
var current_conversation = []
var current_faces = []
var current_face_order = []
var current_conversation_length = 0
var recruiter_faces = [preload("res://assets/postavy/predavač0000.png"), preload("res://assets/postavy/predavač0001.png"),preload("res://assets/postavy/predavač0002.png")]
var recruiter_talk = ["Hello, you can use wasd to move, f to jump, hold r to enter door.",
 "Use left mouse button to attak with meele, or press e to use magic wand if you have one.",
"When using meele, hold to charge powerful attak, but not for too long, it will eventualy lose power.",
"Block while using meele woth right mouse click, but be aware, you must block longer for it to be efective, but you might still recieve some damage.",
"You have magic shield, it will block projectiles, dont worry about it eunning out. But after that projectiles will hurt you too!",
"And keep in mind this is demo. Full version will be availible in 2050.",
 "We are also looking for peope, who would be dying... (coughgs) ehm... dying for adventure in tddddddhe Frozen."]
var recruiter_face_order = [0,1,1,1,2,1,1]
var recruiter_conversation_length = 7
func recruiter():
	$conversation.show()
	current_conversation = recruiter_talk
	current_faces = recruiter_faces
	current_face_order = recruiter_face_order
	current_conversation_length = recruiter_conversation_length
	konverzácia(0)
	
var tutorial_talk = ['Be careful!', 'Don\'t forget how to move, using a,w,d, please.','You know you can attak with meele using mouse. Or hold click for more powerful blow, but don\'t hold for too long. Please! Hold right click to reduce damage.','Get magic, don\'t get near them.','If you obtain staff, use R.','Get stronger by being wiser.','Good luck!']
var tutorial_faces =  [preload("res://assets/postavy/recruiter0000.png"), preload("res://assets/postavy/recruiter0001.png"),preload("res://assets/postavy/recruiter0002.png")]
var tutorial_face_order = [0,1,1,1,1,1,1]
var tutorial_conversation_length = 7
func tutorial():
	$conversation.show()
	current_conversation = tutorial_talk
	current_faces =tutorial_faces
	current_face_order = tutorial_face_order
	current_conversation_length = tutorial_conversation_length
	konverzácia(0)
var doctor_face = [preload("res://assets/postavy/doktor_face_1.png"),preload("res://assets/postavy/doktor_face_2.png"),preload("res://assets/postavy/doktor_face_3.png")]
var doctor_talk = ['Woah, so you`re acctualy up. Tought you were gone. Let me tell you after such injury it is quite miracle. Calm down, slowly. I think you might forgot how to walk, try pressing "a" or "d". After a proper stetching maybe try jump a little "w". AND REMEMBER game only saves when you pass door.',
'Do you know what is your name? Doesnt surprise me either. Like do you even know how to pass door, collect or talk? ha ha, use "r". For attack use "left mouse", using "right mouse" blocks, but it barely does anything, it is still developed. If you obtain magic staff use "e" to switch. When you buy something equip it in equipment menu, top left. ',
'Want to know what happened to you? uuf. I found you ...',
'So dont worry, we will be always there for you to recover, also you have a debt of 500 gold, I mean you have some time to get it, but hurry because there are other ways to get these money from you, but you might not like them.']
var doctor_face_order = [1,0,1,2]
var doctor_conversation_length = 4
func doctor_init():
	$conversation.show()
	current_conversation =doctor_talk
	current_faces = doctor_face
	current_conversation_length = doctor_conversation_length
	current_face_order = doctor_face_order
	konverzácia(0)	
# univery8lna funkcia pre konverzáciu
func konverzácia(i):
	if current_faces == [preload('res://assets/postavy/smugler_face_1.png')] and conversation_progres == 2 && !GameManager.package:
		update_log_info('Package recieved')
		GameManager.package = true
	if current_faces == [preload("res://assets/postavy/smugler_end_face.png")] and conversation_progres == 3 and GameManager.package:
		update_log_info('you recieved 500 gold')
		GameManager.gold += 500
	#print(i)
	#print(current_conversation)
		
		
		
		
		
	if i == current_conversation_length:
		conversation_progres = 0
		$conversation.hide()
		current_conversation = []
		current_conversation_length = 0
		current_faces = []
		current_face_order = []
		return
	$conversation/conversation_text.text = current_conversation[i]
	$conversation/conversation_face.texture = current_faces[current_face_order[i]]

var conversation_progres = 1
func _on_advance_in_conversation_pressed() -> void:
	konverzácia(conversation_progres)
	conversation_progres += 1
	
func _on_decline_pressed() -> void:
	conversation_progres = 1
	$conversation.hide()

func show_view(view_image):
	$view.show()
	$view.texture = view_image
	view_bool = true
	

func _on_eq_necklace_ice_pressed() -> void:
	if GameManager.necklaces_bought[0] == true:
		player.neckleace_equip(1)
	GameManager.equiped_necklace = 1
func _on_eq_necklace_earth_pressed() -> void:
	if GameManager.necklaces_bought[1] == true:
		player.neckleace_equip(2)
	GameManager.equiped_necklace = 2
func _on_eq_necklace_fire_pressed() -> void:
		if GameManager.necklaces_bought[2] == true:
			player.neckleace_equip(3)
		GameManager.equiped_necklace = 3
func _on_eq_necklace_wind_pressed() -> void:
	if GameManager.necklaces_bought[3] == true:
		player.neckleace_equip(4)
	GameManager.equiped_necklace = 4
func _on_eq_necklace_unequip_pressed() -> void:
	player.neckleace_equip(0)
# meele equipment buttons
func _on_eq_meele_ice_pressed() -> void:
	player.meele_weapeon_equip(1)
	GameManager.equiped_meele = 1
func _on_eq_meele_earth_pressed() -> void:
	player.meele_weapeon_equip(2)
	GameManager.equiped_meele = 2
func _on_eq_meele_fire_pressed() -> void:
	player.meele_weapeon_equip(3)
	GameManager.equiped_meele = 3
func _on_eq_meele_wind_pressed() -> void:
	player.meele_weapeon_equip(4)
	GameManager.equiped_meele = 4
func _on_eq_meele_unequip_pressed() -> void:
	player.meele_weapeon_equip(0)
	GameManager.equiped_meele = 0


func _on_wisdom_pressed() -> void:

	wisdom_switch = !wisdom_switch
	if wisdom_switch:
		$Upgrade_wisdom.show()
	else:
		$Upgrade_wisdom.hide()
	await get_tree().create_timer(0.1).timeout
	$Options/HBoxContainer/wisdom.release_focus()
func _on_w_meele_but_pressed() -> void:
	$Upgrade_wisdom/w_meele_class.show()
	$Upgrade_wisdom/w_magic_class.hide()
	$Upgrade_wisdom/w_stats_class.hide()
	$Upgrade_wisdom/convert.hide()

func _on_w_magic_but_pressed() -> void:
	$Upgrade_wisdom/w_meele_class.hide()
	$Upgrade_wisdom/w_magic_class.show()
	$Upgrade_wisdom/w_stats_class.hide()
	$Upgrade_wisdom/convert.hide()
func _on_w_other_but_pressed() -> void:
	$Upgrade_wisdom/w_meele_class.hide()
	$Upgrade_wisdom/w_magic_class.hide()
	$Upgrade_wisdom/w_stats_class.show()
	$Upgrade_wisdom/convert.hide()

func _on_w_convert_pressed() -> void:
	$Upgrade_wisdom/w_meele_class.hide()
	$Upgrade_wisdom/w_magic_class.hide()
	$Upgrade_wisdom/w_stats_class.hide()
	$Upgrade_wisdom/convert.show()
	
func _on_w_meele_a_but_pressed() -> void:
	if GameManager.wisdom_upgrade > 0:
		#print('upgrade')
		GameManager.meele_variables[0] += 0.3
		$Upgrade_wisdom/w_meele_class/A/A_value.text = 'A = '+str(GameManager.meele_variables[0])
		player.A += 0.3
		GameManager.wisdom_upgrade -= 1
		GameManager.spent_upgrades += 1
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
func _on_w_meele_a_but_2_pressed() -> void:
	if GameManager.wisdom_upgrade >= 10:
		#print('upgrade')
		GameManager.meele_variables[0] += 3
		$Upgrade_wisdom/w_meele_class/A/A_value.text = 'A = '+str(GameManager.meele_variables[0])
		player.A += 3
		GameManager.wisdom_upgrade -= 10
		GameManager.spent_upgrades += 10
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
	
	
func _on_w_meele_h_but_pressed() -> void:
	if GameManager.wisdom_upgrade > 0:
		GameManager.meele_variables[2] -= 0.05
		$Upgrade_wisdom/w_meele_class/h/h_value.text = 'h = '+str(GameManager.meele_variables[2])
		player.h -= 0.05
		GameManager.wisdom_upgrade -= 1
		GameManager.spent_upgrades += 1
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
func _on_w_meele_h_but_2_pressed() -> void:
	if GameManager.wisdom_upgrade >= 10:
		GameManager.meele_variables[2] -= 0.5
		$Upgrade_wisdom/w_meele_class/h/h_value.text = 'h = '+str(GameManager.meele_variables[2])
		player.h -= 0.5
		GameManager.wisdom_upgrade -= 10
		GameManager.spent_upgrades += 10
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
		
		
func _on_w_meele_f_but_pressed() -> void:
	if GameManager.wisdom_upgrade > 0:
		#print('upgrade')
		GameManager.meele_variables[1] += 0.2
		$Upgrade_wisdom/w_meele_class/F/F_value.text = 'F = '+str(GameManager.meele_variables[1])
		player.F += 0.2
		GameManager.wisdom_upgrade -= 1
		GameManager.spent_upgrades += 1
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
func _on_w_meele_f_but_2_pressed() -> void:
	if GameManager.wisdom_upgrade >= 10:
		#print('upgrade')
		GameManager.meele_variables[1] += 2
		$Upgrade_wisdom/w_meele_class/F/F_value.text = 'F = '+str(GameManager.meele_variables[1])
		player.F += 2
		GameManager.wisdom_upgrade -= 10
		GameManager.spent_upgrades += 10
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
	
func _on_w_meele_s_but_pressed() -> void:
	if GameManager.wisdom_upgrade > 0:
		GameManager.meele_variables[3] += 0.15
		$Upgrade_wisdom/w_meele_class/sigma/s_value.text = 'sigma \n= '+str(GameManager.meele_variables[3])
		player.sigma += 0.15
		GameManager.wisdom_upgrade -= 1
		GameManager.spent_upgrades += 1
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
func _on_w_meele_s_but_2_pressed() -> void:
	if GameManager.wisdom_upgrade >= 10:
		GameManager.meele_variables[3] += 1.5
		$Upgrade_wisdom/w_meele_class/sigma/s_value.text = 'sigma \n= '+str(GameManager.meele_variables[3])
		player.sigma += 1.5
		GameManager.wisdom_upgrade -= 10
		GameManager.spent_upgrades += 10
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
		
		
func calculate_needed_points():
	return round(PI*exp(1)*log(sqrt(pow(GameManager.wisdom_upgrade_level,3)+1)))
func calculate_needed_points_10():
	var sum = 0
	for i in range(0,10):
		sum += round(PI*exp(1)*log(sqrt(pow(GameManager.wisdom_upgrade_level+i,3)+1)))
	#print('10 points: ',sum)
	return sum
func _on_convert_pressed() -> void:
	var points_needed = calculate_needed_points()
	if GameManager.wisdom_points > points_needed:
		GameManager.wisdom_points -= points_needed
		GameManager.wisdom_upgrade += 1
		GameManager.wisdom_upgrade_level += 1
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
		$Upgrade_wisdom/convert/wisdom_points_counter.text = str(GameManager.wisdom_points)
		$Upgrade_wisdom/convert/convert.text = 'convert to upgrade - points needed:  '+str(calculate_needed_points())
		$Upgrade_wisdom/convert/wisdom_not_enough.hide()
		$Upgrade_wisdom/convert/total_upgrades.text ='Total upgrades: '+ str(GameManager.wisdom_upgrade_level)
	else:
		$Upgrade_wisdom/convert/wisdom_not_enough.show()
		
func _on_convert_10_pressed() -> void:
	var points_needed = calculate_needed_points_10()
	if GameManager.wisdom_points > points_needed:
		GameManager.wisdom_points -= points_needed
		GameManager.wisdom_upgrade += 10
		GameManager.wisdom_upgrade_level += 10
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
		$Upgrade_wisdom/convert/wisdom_points_counter.text = str(GameManager.wisdom_points)
		$Upgrade_wisdom/convert/convert_10.text = 'covert to 10 upgrades - points needed: '+str(calculate_needed_points_10())
		$Upgrade_wisdom/convert/wisdom_not_enough.hide()
		$Upgrade_wisdom/convert/total_upgrades.text ='Total upgrades: '+ str(GameManager.wisdom_upgrade_level)
	else:
		$Upgrade_wisdom/convert/wisdom_not_enough.show()

func _on_w_reset_pressed() -> void:
	if GameManager.gold > 100 :
		GameManager.gold -= 100
		GameManager.wisdom_upgrade = GameManager.wisdom_upgrade_level
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)

		GameManager.meele_variables[0] = 8
		GameManager.meele_variables[1] = 5
		GameManager.meele_variables[2] = 2.5
		GameManager.meele_variables[3] = 1.1
		
		GameManager.magic_variables[0] = 5
		GameManager.magic_variables[1] = 1
		GameManager.magic_variables[2] = 500
		
		GameManager.base_health = 50
		GameManager.base_shield = 200
		
		player.A = 8
		player.F = 5
		player.h = 2.5
		player.sigma = 1.1
		
		player.projectile_damage = 5
		player.fire_rate = 1
		player.pr_speed = 500
		
		player.base_max_health = 50
		player.base_max_shield = 200 
		
		player.update_stats()

		$Upgrade_wisdom/w_meele_class/A/A_value.text = 'A - 8'
		$Upgrade_wisdom/w_meele_class/h/h_value.text = 'h - 2.5'
		$Upgrade_wisdom/w_meele_class/sigma.text = 'sigma - 1.1'
		$Upgrade_wisdom/w_meele_class/F/F_value.text = 'F - 5'
		
		$Upgrade_wisdom/w_magic_class/R/R_value.text = 'R - 1'
		$Upgrade_wisdom/w_magic_class/PD/PD_value.text = 'PD - 5'
		$Upgrade_wisdom/w_magic_class/SPD/SPD_value.text = 'SPD - 500'
		
		$Upgrade_wisdom/w_stats_class/w_stats_h/health_value.text = '50'
		$Upgrade_wisdom/w_stats_class/w_stats_s/shield_value.text = '200'
		
		GameManager.spent_upgrades = 0
		
func _on_w_magic_pd_but_pressed() -> void:
	if GameManager.wisdom_upgrade > 0:
		GameManager.magic_variables[0] += 0.5
		$Upgrade_wisdom/w_magic_class/PD/PD_value.text = 'PD - '+str(GameManager.magic_variables[0])
		player.projectile_damage += 0.5
		GameManager.wisdom_upgrade -= 1
		GameManager.spent_upgrades += 1
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
func _on_w_magic_pd_but_2_pressed() -> void:
	if GameManager.wisdom_upgrade >= 10:
		GameManager.magic_variables[0] += 5
		$Upgrade_wisdom/w_magic_class/PD/PD_value.text = 'PD - '+str(GameManager.magic_variables[0])
		player.projectile_damage += 5
		GameManager.wisdom_upgrade -= 10
		GameManager.spent_upgrades += 10
		$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)

func _on_w_magic_spd_but_pressed() -> void:
		if GameManager.wisdom_upgrade > 0:
			GameManager.magic_variables[2] += 25
			$Upgrade_wisdom/w_magic_class/SPD/SPD_value.text = 'SPD - '+str(GameManager.magic_variables[2])
			player.pr_speed += 25
			GameManager.wisdom_upgrade -= 1
			GameManager.spent_upgrades += 1
			$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
func _on_w_magic_spd_but_2_pressed() -> void:
		if GameManager.wisdom_upgrade >= 10:
			GameManager.magic_variables[2] += 250
			$Upgrade_wisdom/w_magic_class/SPD/SPD_value.text = 'SPD - '+str(GameManager.magic_variables[2])
			player.pr_speed += 250
			GameManager.wisdom_upgrade -= 10
			GameManager.spent_upgrades += 10
			$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)



func _on_w_magic_r_but_pressed() -> void:
		if GameManager.wisdom_upgrade > 0:
			GameManager.magic_variables[1] -= GameManager.magic_variables[1]*0.03
			player.fire_rate -= player.fire_rate*0.03
			$Upgrade_wisdom/w_magic_class/R/R_value.text = 'R - '+str(GameManager.round_to_dec(GameManager.magic_variables[1],2))
			
			GameManager.wisdom_upgrade -= 1
			GameManager.spent_upgrades += 1
			$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
func _on_w_magic_r_but_2_pressed() -> void:
		if GameManager.wisdom_upgrade >= 10:
			for i in range(10):
				GameManager.magic_variables[1] -= GameManager.magic_variables[1]*0.03
			player.fire_rate -= GameManager.magic_variables[1]
			$Upgrade_wisdom/w_magic_class/R/R_value.text = 'R - '+str(GameManager.round_to_dec(GameManager.magic_variables[1],2))
			GameManager.wisdom_upgrade -= 10
			GameManager.spent_upgrades += 10
			$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
			
			
			
			
			
			
func _on_w_other_health_but_pressed() -> void:
	if GameManager.wisdom_upgrade > 0:
			GameManager.base_health += 2
			$Upgrade_wisdom/w_stats_class/w_stats_h/health_value.text = str(GameManager.base_health)
			player.base_max_health += 2
			GameManager.wisdom_upgrade -= 1
			GameManager.spent_upgrades += 1
			$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
			player.update_stats()

func _on_w_other_health_but_10_pressed() -> void:
	if GameManager.wisdom_upgrade >= 10:
			GameManager.base_health += 20
			$Upgrade_wisdom/w_stats_class/w_stats_h/health_value.text = str(GameManager.base_health)
			player.base_max_health += 20
			GameManager.wisdom_upgrade -= 10
			GameManager.spent_upgrades += 10
			$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
			player.update_stats()
	
func _on_w_other_shield_but_pressed() -> void:
		if GameManager.wisdom_upgrade > 0:
			GameManager.base_shield += 5
			$Upgrade_wisdom/w_stats_class/w_stats_s/shield_value.text = str(GameManager.base_shield)
			player.base_max_shield += 5
			GameManager.wisdom_upgrade -= 1
			GameManager.spent_upgrades += 1
			$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
			player.update_stats()
func _on_w_other_shield_but_2_pressed() -> void:
		if GameManager.wisdom_upgrade >= 10:
			GameManager.base_shield += 50
			$Upgrade_wisdom/w_stats_class/w_stats_s/shield_value.text = str(GameManager.base_shield)
			player.base_max_shield += 50
			GameManager.wisdom_upgrade -= 10
			GameManager.spent_upgrades += 10
			$Upgrade_wisdom/wisdom_points_counter.text = str(GameManager.wisdom_upgrade)
			player.update_stats()
func _on_ws_option_1_pressed() -> void:	
	if GameManager.gold > ws_cost_1:
		wisdom_lockdown('folk',ws_cost_1)
		GameManager.gold -= ws_cost_1
		ws_cost_1 = round(rng.randfn(375,150))
		$Wisdom_shop/ws_option_1/ws_cost_1.text = 'Cost: '+str(ws_cost_1)
func _on_ws_exit_pressed() -> void:
	$Wisdom_shop.hide()
var rng = RandomNumberGenerator.new()
func _on_ws_option_2_pressed() -> void:
	if GameManager.gold > ws_cost_2:
		wisdom_lockdown('oth',ws_cost_2)
		GameManager.gold -= ws_cost_2
		ws_cost_2 = round(rng.randfn(375,150))
		$Wisdom_shop/ws_option_2/ws_cost_2.text = 'Cost: '+str(ws_cost_2)
func _on_ws_option_3_pressed() -> void:
	if GameManager.gold > ws_cost_3:
		wisdom_lockdown('fab',ws_cost_3)
		GameManager.gold -= ws_cost_3
		ws_cost_3 = round(rng.randfn(375,150))
		$Wisdom_shop/ws_option_3/ws_cost_3.text = 'Cost: '+str(ws_cost_3)
		
func open_wisdom_shop():
	$Wisdom_shop.show()

func choose_story(type):
	var availivble = []
	if type == 1:
		for i in seen_folk_wisdom:
			if i != -1:
				availivble.append(i)
				
		if availivble.is_empty():
			return 'Všetko'
		
		var index = availivble.pick_random()
		seen_folk_wisdom[index] = -1
#		return folk_wisdom[index]
		
	elif type == 2:
		for i in seen_fables:
				if i != -1:
					availivble.append(i)
					
		if availivble.is_empty():
			return 'Všetko'
			
		var index = availivble.pick_random()
		seen_fables[index] = -1
		return fables[index]
	elif type == 3:
		return ''

func blackout(speed,delta):
	#print('blackout show')
	$Blackout.color.a = move_toward($Blackout.color.a, 1, speed*delta)
	
	
func undo_blackout(speed,delta):

	$Blackout.color.a = move_toward($Blackout.color.a, 0, speed*delta)
#wisdom upgrade update

#blocking static/% damage reduction?
# tower where wisdom szstem s wxplained
# info tab - at the end...
#kopijn9k enenmy that chooese between 2 attaks low and high, you have to be pozotny to see where is his next attak there is a hint
# background wisdom tower and dark tower
# random spawns of enemies (+ gamemanager npc list updator)
# tick animations uhh
# pop up menu to stay between levels
# presťahovať shop na viacero miest
# levely pre meče - zlepšenie efektu nie statov
# nakresli5 tutorial cutscene
# druhé mesto a členité cesty medzi jedným čo už je


func _on_minimap_button_pressed() -> void:

	mimimap_switch = !mimimap_switch
	if mimimap_switch:
		$minimap.show()
	else:
		$minimap.hide()
	await get_tree().create_timer(0.1).timeout
	$Options/HBoxContainer/minimap_button.release_focus()

func _on_world_map_button_pressed() -> void:
	
	
	wm_switch = !wm_switch
	if wm_switch:
		$world_map.show()
	else:
		$world_map.hide()
	await get_tree().create_timer(0.1).timeout
	$Options/HBoxContainer/world_map_button.release_focus()
func update_minimap_map(picture, _x_offset, _y_offset):
	x_offset = _x_offset
	y_offset = _y_offset
	if picture:
		$minimap/map_picture.texture = picture
	


func _on_r_exit_pressed() -> void:
	$riddle.hide()
	get_tree().paused = false
var riddle_key = ''
var riddle_door 
func _on_r_submit_pressed() -> void:
	var text = $riddle/r_lineedit.text
	if text == riddle_key:
		riddle_door.open()
		$riddle.hide()
		get_tree().paused = false
	else:
		$riddle/r_lineedit.text = ''
		$riddle/r_lineedit.grab_focus()
	
	
func riddle_init(key,door,text):
	$riddle.show()
	riddle_key = key
	riddle_door = door
	$riddle/r_text.text=  text
	$riddle.position = Vector2(150,150)
	await get_tree().process_frame
	$riddle/r_lineedit.clear()
	$riddle/r_lineedit.grab_focus()
	get_tree().paused = true


func _on_r_lineedit_text_submitted(new_text: String) -> void:
	_on_r_submit_pressed()
	
func death_ui(last_cause):

	$lostscreen.show()
	$lostscreen/ls_text.text += '\nCause: \n'+last_cause
	
	var random = randf()
	if  random >0.95:
		$lostscreen/ls_text.text += '\nyou could do better'
	if random >0.9 and random < 0.95:
		$lostscreen/ls_text.text += '\nlol'
	
func update_world_ui(level):
	reset_world_ui()
	match level:
		"res://scenes/levely/drotaverin.tscn":
			$world_map/wm_levels/drotaverin.color = Color('#b1a061')
		"res://scenes/levely/les.tscn":
			$world_map/wm_levels/les.color = Color('#b1a061')
		"res://scenes/levely/les_2.tscn":
			$world_map/wm_levels/les_2.color = Color('#b1a061')
		"res://scenes/levely/les_3.tscn":
			$world_map/wm_levels/les_3.color = Color('#b1a061')
		"res://scenes/levely/les_4.tscn":
			$world_map/wm_levels/les_4.color = Color('#b1a061')
		"res://scenes/levely/les_5.tscn":
			$world_map/wm_levels/les_5.color = Color('#b1a061')
		"res://scenes/levely/les_6.tscn":
			$world_map/wm_levels/les_6.color = Color('#b1a061')
		"res://scenes/levely/les_7.tscn":
			$world_map/wm_levels/les_7.color = Color('#b1a061')
		"res://scenes/levely/les_8.tscn":
			$world_map/wm_levels/les_8.color = Color('#b1a061')
		"res://scenes/levely/les_9.tscn":
			$world_map/wm_levels/les_9.color = Color('#b1a061')
		"res://scenes/levely/les_10.tscn":
			$world_map/wm_levels/les_10.color = Color('#b1a061')
		"res://scenes/levely/les_11.tscn":
			$world_map/wm_levels/les_11.color = Color('#b1a061')
		"res://scenes/levely/les_12.tscn":
			$world_map/wm_levels/les_12.color = Color('#b1a061')
		"res://scenes/levely/les_13.tscn":
			$world_map/wm_levels/les_13.color = Color('#b1a061')
		"res://scenes/levely/les_14.tscn":
			$world_map/wm_levels/les_14.color = Color('#b1a061')
		"res://scenes/levely/les_15.tscn":
			$world_map/wm_levels/les_15.color = Color('#b1a061')
		"res://scenes/levely/les_16.tscn":
			$world_map/wm_levels/les_16.color = Color('#b1a061')
		"res://scenes/levely/les_17.tscn":
			$world_map/wm_levels/les_17.color = Color('#b1a061')
		"res://scenes/levely/les_18.tscn":
			$world_map/wm_levels/les_18.color = Color('#b1a061')
		"res://scenes/levely/les_19.tscn":
			$world_map/wm_levels/les_19.color = Color('#b1a061')
		"res://scenes/levely/F1.tscn":
			$world_map/wm_levels/WF.color = Color('#b1a061')
		"res://scenes/levely/kvetiny.tscn":
			$world_map/wm_levels/kvetiny.color = Color('#b1a061')
		"res://scenes/levely/lesne_mesto.tscn":
			$world_map/wm_levels/SM.color = Color('#b1a061')
		"res://scenes/levely/lianova_veza.tscn":
			$world_map/wm_levels/LV_I.color = Color('#b1a061')
		"res://scenes/levely/lianova_veza_II.tscn":
			$world_map/wm_levels/LV_II.color = Color('#b1a061')
		"res://scenes/levely/mesto_na_lanach.tscn":
			$world_map/wm_levels/MNL.color = Color('#b1a061')
		"res://scenes/levely/S.tscn":
			$world_map/wm_levels/S.color = Color('#b1a061')
		"res://scenes/levely/strom.tscn":
			$world_map/wm_levels/T.color = Color('#b1a061')
		"res://scenes/levely/tutorial.tscn":
			$world_map/wm_levels/H.color = Color('#b1a061')

			
func reset_world_ui():
	$world_map/wm_levels/drotaverin.color = Color('#ad9f81')
	$world_map/wm_levels/les_3.color = Color('#ad9f81')
	$world_map/wm_levels/les_5.color = Color('#ad9f81')
	$world_map/wm_levels/les_6.color = Color('#ad9f81')
	$world_map/wm_levels/les_7.color = Color('#ad9f81')
	$world_map/wm_levels/les_8.color = Color('#ad9f81')
	$world_map/wm_levels/les_9.color = Color('#ad9f81')
	$world_map/wm_levels/les_10.color = Color('#ad9f81')
	$world_map/wm_levels/les_11.color = Color('#ad9f81')
	$world_map/wm_levels/les_12.color = Color('#ad9f81')
	$world_map/wm_levels/les_13.color = Color('#ad9f81')
	$world_map/wm_levels/les_14.color = Color('#ad9f81')
	$world_map/wm_levels/les_15.color = Color('#ad9f81')
	$world_map/wm_levels/les_16.color = Color('#ad9f81')
	$world_map/wm_levels/les_17.color = Color('#ad9f81')
	$world_map/wm_levels/les_18.color = Color('#ad9f81')
	$world_map/wm_levels/S.color = Color('#ad9f81')
	$world_map/wm_levels/les_2.color = Color('#ad9f81')
	$world_map/wm_levels/les_4.color = Color('#ad9f81')
	$world_map/wm_levels/les.color = Color('#ad9f81')
	$world_map/wm_levels/WF.color = Color('#ad9f81')
	$world_map/wm_levels/LV_I.color = Color('#ad9f81')
	$world_map/wm_levels/LV_II.color = Color('#ad9f81')
	$world_map/wm_levels/T.color = Color('#ad9f81')
	$world_map/wm_levels/SM.color = Color('#ad9f81')
	$world_map/wm_levels/H.color = Color('#ad9f81')
	
	
	


func _on_ca_exit_pressed() -> void:
	$caje_shop.hide()
	
func caj_init():
	$caje_shop.show()


func _on_ol_exit_pressed() -> void:
	$olej_shop.hide()
func olej_init():
	$olej_shop.show()
	
	


func _on_al_exit_pressed() -> void:
	$alcohol_shop.hide()
func alc_init():
	$alcohol_shop.show()

func _on_buy_alcohol_pressed() -> void:
	if GameManager.gold >= 100:
		GameManager.solution[1] += 1
		GameManager.gold -= 100
		$alcohol_shop/al_talk.text = 'bought'
	else:
		$alcohol_shop/al_talk.text ='not enough money'

func _on_buy_purified_water_pressed() -> void:
	if GameManager.gold >= 25:
		
		GameManager.solution[0] += 1
		GameManager.gold -= 25
		$alcohol_shop/al_talk.text = 'bought'
	else:
		$alcohol_shop/al_talk.text ='not enough money'

func _on_buy_oil_pressed() -> void:
	if GameManager.gold >= 500:
		
		GameManager.solution[2] += 1
		GameManager.gold -= 500
		$olej_shop/ol_talk.text = 'bought'
	else:
		$olej_shop/ol_talk.text ='not enough money'

func _on_caje_sell_pressed() -> void:
	$caje_shop/sell.show()
	$caje_shop/cajoviny.hide()


func _on_caje_buy_pressed() -> void:
	$caje_shop/sell.hide()
	$caje_shop/cajoviny.show()


func _on_caj_up_pressed() -> void:
	var plants = GameManager.plants
	if GameManager.caje[0]:
		$caje_shop/cajoviny/already_bought.show()
		$caje_shop/cajoviny/not_enouhg.hide()
	elif plants['mata'] >= 75 and plants['prvosienky'] >= 10 and plants['trezalka'] >= 5 and plants['marinka'] >=5:
		GameManager.plants['mata'] -= 75
		GameManager.plants['prvosienky'] -= 10
		GameManager.plants['trezalka'] -= 5
		GameManager.plants['marinka'] -= 5
		get_parent().get_node('Player').caj_up()
		GameManager.caje[0] = 1
		$caje_shop/cajoviny/not_enouhg.hide()
		$caje_shop/cajoviny/already_bought.hide()
	else:
		$caje_shop/cajoviny/not_enouhg.show()
		$caje_shop/cajoviny/already_bought.hide()
func _on_caj_dych_pressed() -> void:
	if GameManager.caje[1]:
		$caje_shop/cajoviny/already_bought.show()
		$caje_shop/cajoviny/not_enouhg.hide()
	elif GameManager.plants['divozel'] >= 20 and GameManager.plants['slez'] >= 15 and GameManager.plants['skorocel'] >= 10 and GameManager.plants['salvia'] >= 10 and GameManager.plants['hluchavka'] >= 20:
		GameManager.plants['divozel'] -= 20
		GameManager.plants['slez'] -= 15
		GameManager.plants['skorocel'] -= 10
		GameManager.plants['salvia'] -= 10
		GameManager.plants['hluchavka'] -= 20
		get_parent().get_node('Player').caj_dych()
		GameManager.caje[1] = 1
		$caje_shop/cajoviny/not_enouhg.hide()
		$caje_shop/cajoviny/already_bought.hide()

	else:
	
		$caje_shop/cajoviny/not_enouhg.show()
		$caje_shop/cajoviny/already_bought.hide()
		
func _on_caj_det_pressed() -> void:
	
	if GameManager.caje[2]:
		$caje_shop/cajoviny/already_bought.show()
		$caje_shop/cajoviny/not_enouhg.hide()
	elif GameManager.plants['zihlava'] >= 35 and GameManager.plants['pupava'] >= 75 and GameManager.plants['alchemilka'] >= 10 and GameManager.plants['cesnak'] >= 15:
		GameManager.plants['zihlava'] -= 35
		GameManager.plants['pupava'] -= 75
		GameManager.plants['alchemilka'] -= 10
		GameManager.plants['cesnak'] -= 15
		get_parent().get_node('Player').caj_det()
		GameManager.caje[2] = 1
		$caje_shop/cajoviny/not_enouhg.hide()
		$caje_shop/cajoviny/already_bought.hide()

	else:
		$caje_shop/cajoviny/not_enouhg.show()
		$caje_shop/cajoviny/already_bought.hide()	
func _on_caj_poz_pressed() -> void:
	if GameManager.caje[3]:
		$caje_shop/cajoviny/already_bought.show()
		$caje_shop/cajoviny/not_enouhg.hide()
	elif GameManager.plants['cakanka'] >= 15 and GameManager.plants['nevadza'] >= 15:
		GameManager.plants['cakanka'] -= 15
		GameManager.plants['nevadza'] -= 15
		get_parent().get_node('Player').caj_poz()
		GameManager.caje[3] = 1
		$caje_shop/cajoviny/not_enouhg.hide()
		$caje_shop/cajoviny/already_bought.hide()

	else:
		$caje_shop/cajoviny/not_enouhg.show()
		$caje_shop/cajoviny/already_bought.hide()


func _on_slez_2_pressed() -> void:
	if GameManager.plants['slez'] >= 10:
		GameManager.gold += 200
		GameManager.plants['slez'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/stredne/Label7/own.text = str(GameManager.plants['slez'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_salvia_2_pressed() -> void:
	if GameManager.plants['salvia'] >= 10:
		GameManager.gold += 200
		GameManager.plants['salvia'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/stredne/Label8/own2.text = str(GameManager.plants['salvia'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_skorocel_2_pressed() -> void:
	if GameManager.plants['skorocel'] >= 10:
		GameManager.gold += 200
		GameManager.plants['skorocel'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/stredne/Label9/own3.text = str(GameManager.plants['skorocel'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_divozel_2_pressed() -> void:
	if GameManager.plants['divozel'] >= 10:
		GameManager.gold += 200
		GameManager.plants['divozel'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/stredne/Label10/own4.text = str(GameManager.plants['divozel'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()


func _on_zihlava_2_pressed() -> void:
	if GameManager.plants['zihlava'] >= 10:
		GameManager.gold += 40
		GameManager.plants['zihlava'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/lacne/Label5/own2.text = str(GameManager.plants['zihlava'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_cesnak_2_pressed() -> void:
	if GameManager.plants['cesnak'] >= 10:
		GameManager.gold += 40
		GameManager.plants['cesnak'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/lacne/Label4/own3.text = str(GameManager.plants['cesnak'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_hluchavka_2_pressed() -> void:
	if GameManager.plants['hluchavka'] >= 10:
		GameManager.gold += 40
		GameManager.plants['hluchavka'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/lacne/Label3/own4.text = str(GameManager.plants['hluchavka'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_pupava_2_pressed() -> void:
	if GameManager.plants['pupava'] >= 10:
		GameManager.gold += 40
		GameManager.plants['pupava'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/lacne/Label2/own5.text = str(GameManager.plants['pupava'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_mata_2_pressed() -> void:
	if GameManager.plants['mata'] >= 10:
		GameManager.gold += 40
		GameManager.plants['mata'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/lacne/Label/own6.text = str(GameManager.plants['mata'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
		
		

func _on_alchemilka_2_pressed() -> void:
	if GameManager.plants['alchemilka'] >= 10:
		GameManager.gold += 1000
		GameManager.plants['alchemilka'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/vzacne/Label11/own5.text = str(GameManager.plants['alchemilka'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_cakanka_2_pressed() -> void:
	if GameManager.plants['cakanka'] >= 10:
		GameManager.gold += 1000
		GameManager.plants['cakanka'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/vzacne/Label12/own6.text = str(GameManager.plants['cakanka'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_marinka_2_pressed() -> void:
	if GameManager.plants['marinka'] >= 10:
		GameManager.gold += 1000
		GameManager.plants['marinka'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/vzacne/Label13/own7.text = str(GameManager.plants['marinka'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_nevedza_pressed() -> void:
	if GameManager.plants['nevadza'] >= 10:
		GameManager.gold += 1000
		GameManager.plants['nevadza'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/vzacne/Label14/own8.text = str(GameManager.plants['nevadza'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_prvosienka_2_pressed() -> void:
	if GameManager.plants['prvosienky'] >= 10:
		GameManager.gold += 1000
		GameManager.plants['prvosienky'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/vzacne/Label16/own9.text = str(GameManager.plants['prvosienky'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_trezalka_2_pressed() -> void:
	if GameManager.plants['trezalka'] >= 10:
		GameManager.gold += 1000
		GameManager.plants['trezalka'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/vzacne/Label15/own10.text = str(GameManager.plants['trezalka'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()


func _on_jesienka_2_pressed() -> void:
	if GameManager.plants['jesienka'] >= 10:
		GameManager.gold += -50
		GameManager.plants['jesienka'] -= 10
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/special/Label17/own11.text = str(GameManager.plants['jesienka'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()
func _on_konvalinka_2_pressed() -> void:
	if GameManager.plants['konvalinka'] >= 1:
		GameManager.gold += 1000
		GameManager.plants['konvalinka'] -= 1
		$caje_shop/sell/sold.show()
		$caje_shop/sell/not_en.hide()
		$caje_shop/sell/special/Label18/own12.text = str(GameManager.plants['konvalinka'])
	else:
		$caje_shop/sell/sold.hide()
		$caje_shop/sell/not_en.show()

func klenotnik_init():
	$klenotnik_shop.show()




func _on_kl_buy_ice_pressed() -> void:
	if GameManager.necklaces_bought[0]:
		$klenotnik_shop/neck/bought.show()
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought_now.hide()
	elif GameManager.sutre['silver'] >=25 and GameManager.sutre['azurite'] >= 5 and GameManager.gold >= 500:
		GameManager.sutre['silver'] -= 25
		GameManager.sutre['azurite'] -= 5
		GameManager.gold -= 500
		GameManager.necklaces_bought[0] = true
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.show()
	else:
		$"klenotnik_shop/neck/no resources".show()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.hide()
func _on_kl_buy_earth_pressed() -> void:
	if GameManager.necklaces_bought[1]:
		$klenotnik_shop/neck/bought.show()
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought_now.hide()
	elif GameManager.sutre['silver'] >=25 and GameManager.sutre['malachite'] >= 2 and GameManager.sutre['uvarovite'] >= 2 and GameManager.gold >= 500:
		GameManager.sutre['silver'] -= 25
		GameManager.sutre['malachite'] -= 2
		GameManager.sutre['uvarovite'] -=2
		GameManager.gold -= 500
		GameManager.necklaces_bought[1] = true
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.show()
	else:
		$"klenotnik_shop/neck/no resources".show()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.hide()
func _on_kl_buy_fire_pressed() -> void:
	if GameManager.necklaces_bought[2]:
		$klenotnik_shop/neck/bought.show()
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought_now.hide()
	elif GameManager.sutre['silver'] >=25 and GameManager.sutre['zincite'] >= 5 and GameManager.gold >= 500:
		GameManager.sutre['silver'] -= 25
		GameManager.sutre['zincite'] -= 5
		GameManager.gold -= 500
		GameManager.necklaces_bought[2] = true
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.show()
	else:
		$"klenotnik_shop/neck/no resources".show()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.hide()
func _on_kl_buy_wind_pressed() -> void:
	if GameManager.necklaces_bought[3]:
		$klenotnik_shop/neck/bought.show()
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought_now.hide()
	elif GameManager.sutre['silver'] >=25 and GameManager.sutre['opal'] >= 5 and GameManager.gold >= 500:
		GameManager.sutre['silver'] -= 25
		GameManager.sutre['opal'] -= 5
		GameManager.gold -= 500
		GameManager.necklaces_bought[3] = true
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.show()
	else:
		$"klenotnik_shop/neck/no resources".show()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.hide()
func _on_kl_buy_ice_g_pressed() -> void:
	if GameManager.necklaces_bought[4]:
		$klenotnik_shop/neck/bought.show()
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought_now.hide()
	elif GameManager.sutre['gold'] >=25 and GameManager.sutre['azurite'] >= 15 and GameManager.gold >= 1500:
		GameManager.sutre['gold'] -= 25
		GameManager.sutre['azurite'] -= 15
		GameManager.gold -= 1500
		GameManager.necklaces_bought[4] = true
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.show()
	else:
		$"klenotnik_shop/neck/no resources".show()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.hide()
func _on_kl_buy_earth_g_pressed() -> void:
	if GameManager.necklaces_bought[5]:
		$klenotnik_shop/neck/bought.show()
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought_now.hide()
	elif GameManager.sutre['gold'] >=25 and GameManager.sutre['malachite'] >= 7 and GameManager.sutre['uvarovite'] and GameManager.gold >= 1500:
		GameManager.sutre['gold'] -= 25
		GameManager.sutre['malachite'] -= 7
		GameManager.sutre['uvarovite'] -=7
		GameManager.gold -= 1500
		GameManager.necklaces_bought[5] = true
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.show()
	else:
		$"klenotnik_shop/neck/no resources".show()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.hide()


func _on_kl_buy_fire_g_pressed() -> void:
	if GameManager.necklaces_bought[6]:
		$klenotnik_shop/neck/bought.show()
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought_now.hide()
	elif GameManager.sutre['gold'] >=25 and GameManager.sutre['zincite'] >= 15 and GameManager.gold >= 1500:
		GameManager.sutre['gold'] -= 25
		GameManager.sutre['zincite'] -= 15
		GameManager.gold -= 1500
		GameManager.necklaces_bought[6] = true
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.show()
	else:
		$"klenotnik_shop/neck/no resources".show()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.hide()



func _on_kl_buy_wind_g_pressed() -> void:
	if GameManager.necklaces_bought[7]:
		$klenotnik_shop/neck/bought.show()
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought_now.hide()
	elif GameManager.sutre['gold'] >=25 and GameManager.sutre['opal'] >= 15 and GameManager.gold >= 1500:
		GameManager.sutre['gold'] -= 25
		GameManager.sutre['opal'] -= 15
		GameManager.gold -= 1500
		GameManager.necklaces_bought[7] = true
		$"klenotnik_shop/neck/no resources".hide()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.show()
	else:
		$"klenotnik_shop/neck/no resources".show()
		$klenotnik_shop/neck/bought.hide()
		$klenotnik_shop/neck/bought_now.hide()


func _on_kl_exit_pressed() -> void:
	$klenotnik_shop.hide()
	
var ab_icon =[ preload("res://assets/UI/icony/icon_none_ab.png"),
preload("res://assets/UI/icony/icon_ice_ab.png"),
 preload("res://assets/UI/icony/icon_earth_ab.png"),
  preload("res://assets/UI/icony/icon_fire_ab.png"),
 preload("res://assets/UI/icony/icon_wind_ab.png"),
preload("res://assets/UI/icony/icon_pierce_ab.png"),
preload("res://assets/UI/icony/icon_teleport_ab.png"),
preload("res://assets/UI/icony/icon_AoE_ab.png"),
]

func update_ab_cd( time,max_time):
	var perc =-snappedf(time / max_time,0.01)
	if perc < 0:
	#	#print(time,' /  ', max_time,' ',perc)
		$ability_icon/ColorRect.scale.y = perc

func update_ab_icon(texture_id):
	#print('icon ab change ',texture_id)
	if texture_id in [0]:
		$ability_icon.hide()
	else:
		$ability_icon.texture = ab_icon[texture_id]


func _on_buy_kalerab_pressed() -> void:
	if !GameManager.food_bought[2] and GameManager.gold >= 100:
		GameManager.food_bought[2] = 1
		GameManager.gold -= 100
		get_parent().get_node('Player').kalerab()
		$olej_shop/ol_talk.text = 'bought'
	elif GameManager.food_bought[2]:
		$olej_shop/ol_talk.text = 'already bought'
	else:
		$olej_shop/ol_talk.text = 'not enough money'



func _on_ryza_pressed() -> void:
	if !GameManager.food_bought[1] and GameManager.gold >= 1500:
		GameManager.food_bought[1] = 1
		GameManager.gold -= 1500
		get_parent().get_node('Player').ryza()
		$olej_shop/ol_talk.text = 'bought'
	elif GameManager.food_bought[1]:
		$olej_shop/ol_talk.text = 'already bought'
	else:
		$olej_shop/ol_talk.text = 'not enough money'
	

func _on_vlocky_pressed() -> void:
	if !GameManager.food_bought[3] and GameManager.gold >= 750:
		GameManager.food_bought[3] = 1
		GameManager.gold -= 750
		get_parent().get_node('Player').vlocky()
		$olej_shop/ol_talk.text = 'bought'
	elif GameManager.food_bought[3]:
		$olej_shop/ol_talk.text = 'already bought'
	else:
		$olej_shop/ol_talk.text = 'not enough money'

func _on_drink_alcohol_pressed() -> void:
	if GameManager.gold >= 100:
		GameManager.gold -= 100
		get_parent().get_node('Player').drink()
		$"alcohol_shop/item_alcohol drink/drink_count".text = str((get_parent().get_node('Player').inaccuracy-0.50) / 0.1)


func _on_bauxite_smelt_pressed() -> void:
	if GameManager.gold >= 150 and GameManager.sutre['bauxit'] >= 10:
		GameManager.gold -= 150
		GameManager.smelted_bars[0] += 1
		GameManager.sutre['bauxit'] -= 10
		$kovac/smelt_cat/Label6.text ='Smelted!'
	else:
		$kovac/smelt_cat/Label6.text ='Not enough resources.'
func _on_iron_smelt_pressed() -> void:
	if GameManager.gold >= 150 and  GameManager.sutre['hematite'] >= 10:
		GameManager.gold -= 150
		GameManager.smelted_bars[1] += 1
		GameManager.sutre['hematite'] -= 10
		$kovac/smelt_cat/Label6.text ='Smelted!'
	else:
		$kovac/smelt_cat/Label6.text ='Not enough resources.'
func _on_antimonite_smelt_pressed() -> void:
	if GameManager.gold >= 250 and  GameManager.sutre['antimonite'] >= 10:
		GameManager.gold -= 250
		GameManager.smelted_bars[2] += 1
		GameManager.sutre['antimonite'] -= 10
		$kovac/smelt_cat/Label6.text ='Smelted!'
	else:
		$kovac/smelt_cat/Label6.text ='Not enough resources.'
func _on_silver_smelt_pressed() -> void:
	if GameManager.gold >= 250  and GameManager.sutre['silver'] >= 10:
		GameManager.gold -= 250
		GameManager.smelted_bars[3] += 1
		GameManager.sutre['silver'] -= 10		
		$kovac/smelt_cat/Label6.text ='Smelted!'
	else:
		$kovac/smelt_cat/Label6.text ='Not enough resources.'
func _on_gold_smelt_pressed() -> void:
	if GameManager.gold >= 500  and GameManager.sutre['gold'] >= 10:
		GameManager.gold -= 500
		GameManager.smelted_bars[4] += 1
		GameManager.sutre['gold'] -= 10	
		$kovac/smelt_cat/Label6.text ='Smelted!'
	else:
		$kovac/smelt_cat/Label6.text ='Not enough resources.'

func _on_smelting_pressed() -> void:
	$kovac/smelt_cat.show()
	$kovac/sell_cat.hide()
	$kovac/smith_cat.hide()
	$kovac/buy_cat.hide()
func _on_ko_sell_pressed() -> void:
	$kovac/smelt_cat.hide()
	$kovac/sell_cat.show()
	$kovac/smith_cat.hide()
	$kovac/buy_cat.hide()
func _on_ko_smithing_pressed() -> void:
	$kovac/smelt_cat.hide()
	$kovac/sell_cat.hide()
	$kovac/smith_cat.show()
	$kovac/buy_cat.hide()
func _on_ko_buy_pressed() -> void:
	$kovac/smelt_cat.hide()
	$kovac/sell_cat.hide()
	$kovac/smith_cat.hide()
	$kovac/buy_cat.show()

func _on_button_sell_bauxite_pressed() -> void:
	if GameManager.sutre['bauxit'] >= 10:
		GameManager.sutre['bauxit'] -= 10
		GameManager.gold += 40
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_hematite_pressed() -> void:
	if GameManager.sutre['hematite'] >= 10:
		GameManager.sutre['hematite'] -= 10
		GameManager.gold += 70
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_antimonite_pressed() -> void:
	if GameManager.sutre['antimonite'] >= 10:
		GameManager.sutre['antimonite'] -= 10
		GameManager.gold += 250
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_silver_pressed() -> void:
	if GameManager.sutre['silver'] >= 10:
		GameManager.sutre['silver'] -= 10
		GameManager.gold += 400
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_gold_pressed() -> void:
	if GameManager.sutre['gold'] >= 10:
		GameManager.sutre['gold'] -= 10
		GameManager.gold += 1000
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_azurite_pressed() -> void:
	if GameManager.sutre['azurite'] >= 5:
		GameManager.sutre['azurite'] -= 5
		GameManager.gold += 1000
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_malachite_pressed() -> void:
	if GameManager.sutre['malachite'] >= 5:
		GameManager.sutre['malachite'] -= 5
		GameManager.gold += 1000
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_opal_pressed() -> void:
	if GameManager.sutre['opal'] >= 5:
		GameManager.sutre['opal'] -= 5
		GameManager.gold += 1000
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_uvarovite_pressed() -> void:
	if GameManager.sutre['uvarovite'] >= 5:
		GameManager.sutre['uvarovite'] -= 5
		GameManager.gold += 1000
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
func _on_button_sell_zincite_pressed() -> void:
	if GameManager.sutre['zincite'] >= 5:
		GameManager.sutre['zincite'] -= 5
		GameManager.gold += 1000
		$kovac/sell_cat/Label.text = 'sold!'
	else:
		$kovac/sell_cat/Label.text ='Not enough resources'
		
func kovac_init():
	$kovac.show()
func _on_ko_exit_pressed() -> void:
	$kovac.hide()


func _on_buy_ice_sword_pressed() -> void:
	if !GameManager.meele_bought[0] and GameManager.gold >= 1000 and GameManager.sutre['azurite'] >= 1 and GameManager.plants['mata'] >=50 and GameManager.smelted_bars[3] >= 1:
		GameManager.gold -= 1000 
		GameManager.sutre['azurite'] -= 1
		GameManager.smelted_bars[3] -= 1
		GameManager.plants['mata'] -= 50
		GameManager.meele_bought[0] = 1
		$kovac/smith_cat/Label.hide()
		$kovac/smith_cat/Label.text = 'bought'
	elif GameManager.meele_bought[0]:
		$kovac/smith_cat/Label.text = 'already bought'
	else:
		$kovac/smith_cat/Label.text = 'Not enough resoureces'
func _on_buy_earth_sword_pressed() -> void:
	if !GameManager.meele_bought[1] and GameManager.gold >= 1000 and GameManager.sutre['uvarovite'] >= 1 and GameManager.plants['cesnak'] >=50 and GameManager.smelted_bars[3] >= 1:
		GameManager.gold -= 1000 
		GameManager.sutre['uvarovite'] -= 1
		GameManager.smelted_bars[3] -= 1
		GameManager.plants['cesnak'] -= 50
		GameManager.meele_bought[1] = 1
		$kovac/smith_cat/Label.text = 'bought'
	elif GameManager.meele_bought[1]:
		$kovac/smith_cat/Label.text = 'already bought'
	else:
		$kovac/smith_cat/Label.text = 'Not enough resoureces'
func _on_buy_fire_sword_pressed() -> void:
	if  !GameManager.meele_bought[2] and GameManager.gold >= 1000 and GameManager.sutre['zincite'] >= 1 and GameManager.plants['zihlava'] >=50 and GameManager.smelted_bars[3] >= 1:
		GameManager.gold -= 1000 
		GameManager.sutre['zincite'] -= 1
		GameManager.smelted_bars[3] -= 1
		GameManager.plants['zihlava'] -= 50
		GameManager.meele_bought[2] = 1
		$kovac/smith_cat/Label.text = 'bought'
	elif GameManager.meele_bought[2]:
		$kovac/smith_cat/Label.text = 'already bought'
	else:
		$kovac/smith_cat/Label.text = 'Not enough resoureces'
func _on_buy_wind_sword_pressed() -> void:
	if  !GameManager.meele_bought[3] and GameManager.gold >= 1000 and GameManager.sutre['opal'] >= 1 and GameManager.plants['pupava'] >=50 and GameManager.smelted_bars[3] >= 1:
		GameManager.gold -= 1000 
		GameManager.sutre['opal'] -= 1
		GameManager.smelted_bars[3] -= 1
		GameManager.plants['pupava'] -= 50
		GameManager.meele_bought[3] = 1
		$kovac/smith_cat/Label.text = 'bought'
	elif GameManager.meele_bought[3]:
		$kovac/smith_cat/Label.text = 'already bought'
	else:
		$kovac/smith_cat/Label.text = 'Not enough resoureces'


func _on_buykoleno_pressed() -> void:
	if GameManager.gold >= 300 and !GameManager.food_bought[4]:
		GameManager.gold -= 300
		GameManager.food_bought[4] = 1
		get_parent().get_node('Player').koleno()
		$kovac/buy_cat/Label2.text = 'bought'
	elif GameManager.food_bought[4]:
		$kovac/buy_cat/Label2.text = 'already bought'
	else:
		$kovac/buy_cat/Label2.text = 'not enough resources'
		
func syry_init():
	$syry_shop.show()
func _on_sy_exit_pressed() -> void:
	$syry_shop.hide()
	
func _on_buy_milk_pressed() -> void:
	if GameManager.gold>= 100 and !GameManager.food_bought[5]:
		GameManager.gold -= 100
		GameManager.food_bought[5] = 1
		get_parent().get_node('Player').mlieko()
		$syry_shop/sy_talk.text = 'bought'
	elif GameManager.food_bought[5]:
		$syry_shop/sy_talk.text = 'already bought'
	else:
		$syry_shop/sy_talk.text= 'not enough money'
func _on_buy_yogurt_pressed() -> void:
	if GameManager.gold>= 250 and !GameManager.food_bought[6]:
		GameManager.gold -= 250
		GameManager.food_bought[6] = 1.
		get_parent().get_node('Player').yogurt()		
		$syry_shop/sy_talk.text = 'bought'
	elif GameManager.food_bought[5]:
		$syry_shop/sy_talk.text = 'already bought'
	else:
		$syry_shop/sy_talk.text= 'not enough money'
func _on_buy_parenuca_n_pressed() -> void:
	if GameManager.gold>= 300 and !GameManager.food_bought[7]:
		GameManager.gold -= 300
		GameManager.food_bought[7] = 1.
		get_parent().get_node('Player').parenica_n()
		$syry_shop/sy_talk.text = 'bought'
	elif GameManager.food_bought[5]:
		$syry_shop/sy_talk.text = 'already bought'
	else:
		$syry_shop/sy_talk.text= 'not enough money'
func _on_buy_parenica_u_pressed() -> void:
	if GameManager.gold>= 350 and !GameManager.food_bought[8]:
		GameManager.gold -= 350
		GameManager.food_bought[8] = 1.
		get_parent().get_node('Player').parenica_u()
		$syry_shop/sy_talk.text = 'bought'
	elif GameManager.food_bought[5]:
		$syry_shop/sy_talk.text = 'already bought'
	else:
		$syry_shop/sy_talk.text= 'not enough money'

func drop_sell_init():
	$drop_sell.show()
func _on_ds_exit_pressed() -> void:
	$drop_sell.hide()

func _on_buy_crystal_ice_pressed() -> void:
	if GameManager.drop_ice[0] >= 1:
		GameManager.drop_ice[0] -=1
		GameManager.gold += 3
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_sell_giant_snowflake_pressed() -> void:
	if GameManager.drop_ice[1] >= 1:
		GameManager.drop_ice[1] -=1
		GameManager.gold += 35
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_buy_frozen_core_pressed() -> void:
	if GameManager.drop_ice[2] >= 1:
		GameManager.drop_ice[2] -=1
		GameManager.gold += 180
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_buy_dense_wood_pressed() -> void:
	if GameManager.drop_earth[0] >= 1:
		GameManager.drop_earth[0] -=1
		GameManager.gold += 3
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_sell_special_leaves_pressed() -> void:
	if GameManager.drop_earth[1] >= 1:
		GameManager.drop_earth[1] -1
		GameManager.gold += 35
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_buy_strange_fruit_pressed() -> void:
	if GameManager.drop_earth[2] >= 1:
		GameManager.drop_earth[2] -= 1
		GameManager.gold += 180
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_buy_ash_pressed() -> void:
	if GameManager.drop_fire[0] >= 1:
		GameManager.drop_fire[0] -=1
		GameManager.gold += 3
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_sell_fire_in_bottle_pressed() -> void:
	if GameManager.drop_fire[1] >= 1:
		GameManager.drop_fire[1] -=1
		GameManager.gold += 35
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_buy_magma_pressed() -> void:
	if GameManager.drop_fire[2] >= 1:
		GameManager.drop_fire[2] -=1
		GameManager.gold += 180
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_buy_wind_feather_pressed() -> void:
	if GameManager.drop_wind[0] >= 1:
		GameManager.drop_wind[0] -=1
		GameManager.gold += 3
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_sell_wind_in_bottle_pressed() -> void:
	if GameManager.drop_wind[1] >= 1:
		GameManager.drop_wind[1] -=1
		GameManager.gold += 35
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_buy_wind_metal_pressed() -> void:
	if GameManager.drop_wind[2] >= 1:
		GameManager.drop_wind[2] -=1
		GameManager.gold += 180
		$drop_sell/ds_talk.text = 'sold!'
	else:
		$drop_sell/ds_talk.text = 'not enough resources'
func _on_ds_ice_pressed() -> void:
	$drop_sell/ice_drops.show()
	$drop_sell/earth_drops.hide()
	$drop_sell/fire_drops.hide()
	$drop_sell/wind_drops.hide()
func _on_ds_earth_pressed() -> void:
	$drop_sell/ice_drops.hide()
	$drop_sell/earth_drops.show()
	$drop_sell/fire_drops.hide()
	$drop_sell/wind_drops.hide()
func _on_ds_fire_pressed() -> void:
	$drop_sell/ice_drops.hide()
	$drop_sell/earth_drops.hide()
	$drop_sell/fire_drops.show()
	$drop_sell/wind_drops.hide()
func _on_ds_wind_pressed() -> void:
	$drop_sell/ice_drops.hide()
	$drop_sell/earth_drops.hide()
	$drop_sell/fire_drops.hide()
	$drop_sell/wind_drops.show()

func jumpscare(jumpscare_type):
	match jumpscare_type:
		1: 
			$jump_scare.show()
			for i in range(100):
				if not is_instance_valid(self) or not is_inside_tree():
					return
				$jump_scare.scale += Vector2(0.07,0.07)
				$jump_scare.position -= Vector2(9.5,9.5)
				await get_tree().process_frame
			$jump_scare.hide()


func _on_buycharger_pressed() -> void:
	if GameManager.gold >= 1500:
		GameManager.gold-=1500
		GameManager.meele_bought[4]= 1


func _on_buysd_pressed() -> void:
	if GameManager.gold >= 500:
			GameManager.gold-=500
			GameManager.meele_bought[5]= 1


func _on_kl_buy_ice_2_pressed() -> void:
	if GameManager.magic_bought[0] ==  1:
		$klenotnik_shop/staff/Label.text = 'Already bought'
	elif GameManager.gold >= 500:
			GameManager.magic_bought[0] =  1
			$klenotnik_shop/staff/Label.text = 'bought'
	else:
		$klenotnik_shop/staff/Label.text = 'Not enough resources'
func _on_kl_buy_ice_3_pressed() -> void:
	if GameManager.magic_bought[1] ==  1:
		$klenotnik_shop/staff/Label.text = 'Already bought'
	elif GameManager.gold >= 500 :
			GameManager.gold-=500
		
			GameManager.magic_bought[1] =  1
			$klenotnik_shop/staff/Label.text = 'bought'
	else:
		$klenotnik_shop/staff/Label.text = 'Not enough resources'
func _on_kl_buy_ice_4_pressed() -> void:
	if GameManager.magic_bought[2] ==  1:
		$klenotnik_shop/staff/Label.text = 'Already bought'
	elif GameManager.gold >= 500 :
			GameManager.gold-=500

			GameManager.magic_bought[2] =  1
			$klenotnik_shop/staff/Label.text = 'bought'
	else:
		$klenotnik_shop/staff/Label.text = 'Not enough resources'
func _on_kl_buy_ice_8_pressed() -> void:
	if GameManager.magic_bought[3] ==  1:
		$klenotnik_shop/staff/Label.text = 'Already bought'
	elif GameManager.gold >= 500 :
			GameManager.gold-=500
			
			GameManager.magic_bought[3] =  1
			$klenotnik_shop/staff/Label.text = 'bought'
	else:
		$klenotnik_shop/staff/Label.text = 'Not enough resources'
			


func _on_kl_buy_ice_5_pressed() -> void:
	if GameManager.magic_bought[4] ==  1:
		$klenotnik_shop/staff/Label.text = 'Already bought'
	elif GameManager.gold >= 2000 and GameManager.smelted_bars[2] >= 1:
			GameManager.gold-=2000
			GameManager.smelted_bars[2] -= 1
			GameManager.magic_bought[4] =  1
			$klenotnik_shop/staff/Label.text = 'bought'
	else:
		$klenotnik_shop/staff/Label.text = 'Not enough resources'
func _on_kl_buy_ice_6_pressed() -> void:
	if GameManager.magic_bought[5] ==  1:
		$klenotnik_shop/staff/Label.text = 'Already bought'
	elif GameManager.gold >= 2000 and GameManager.smelted_bars[2] >= 1:
			GameManager.gold-=2000
			GameManager.smelted_bars[2] -= 1
			GameManager.magic_bought[5] =  1
			$klenotnik_shop/staff/Label.text = 'bought'
	else:
		$klenotnik_shop/staff/Label.text = 'Not enough resources'
func _on_kl_buy_ice_7_pressed() -> void:
	if GameManager.magic_bought[6] ==  1:
		$klenotnik_shop/staff/Label.text = 'Already bought'
	elif GameManager.gold >= 2000 and GameManager.smelted_bars[2] >= 1:
			GameManager.gold-=2000
			GameManager.smelted_bars[2] -= 1
			GameManager.magic_bought[6] =  1
			$klenotnik_shop/staff/Label.text = 'bought'
	else:
		$klenotnik_shop/staff/Label.text = 'Not enough resources'


func _on_kl_exit_2_pressed() -> void:
	$klenotnik_shop/staff.hide()
	$klenotnik_shop/neck.show()

func _on_kl_exit_3_pressed() -> void:
	$klenotnik_shop/staff.show()
	$klenotnik_shop/neck.hide()
