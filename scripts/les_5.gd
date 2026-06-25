extends Node2D

var level_enemies =[]
@export var respawn_time = 1
var player
var spawn = GameManager.player_spawn
var spawn_position
@export var level_name = ''
var deadlist
var treasures
var wisdom
var level_treasures = []
var level_wisdom =[]
var ch = get_children()
@export var x_offset = 0
@export var y_offset = 0
@export var minimap_picture = Texture
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	'''
	if level_name == 'les_16':
		#print('--------------------------------------------------------------')
		var local_points = PackedVector2Array()
		for point in $ground46/Polygon2D10.polygon:
			local_points.append(to_local(point))  # wrong approach if parent has offset
		var overlay = Polygon2D.new()
		overlay.polygon = $ground46/Polygon2D10.polygon
		overlay.position = $ground46/Polygon2D10.global_position - global_position
		overlay.color = Color(0.5, 0.5, 0.5, 0.8)
		overlay.z_index = 2
		add_child(overlay)
		#print("Overlay polygon points: ", overlay.polygon)
		#print("Overlay position: ", overlay.global_position)
		#print("Overlay visible: ", overlay.visible)
		
	'''
	get_child(0).update_minimap_map(minimap_picture, x_offset, y_offset)
	deadlist = GameManager.npc_deadlist(level_name)
	
	treasures = GameManager.treasures[level_name]
	wisdom = GameManager.collected_wisdom[level_name]
	get_tree().current_scene.get_child(0).get_child(5).hide()
	await get_tree().create_timer(0.05).timeout
	kill_dead()
	open_known_treasures()
	open_known_wisdom()
	#print(level_name)
	#print('spawn = ',spawn)
	# každý level mohol mať vlastné id a všeky markery z neho von by sa volali rovnako
	if spawn == 101:
		spawn_position = $spawn_down.position
	if spawn == 102:
		spawn_position =$spawn_uo.position
	if spawn == 103:
		spawn_position = $vchod.position
	if spawn == 104:
		spawn_position = $do_stromu.position
	if spawn == 105:
		spawn_position = $Marker_right_entrace.position
	if spawn == 106:
		spawn_position = $from_les2.position
	if spawn == 107:
		spawn_position =$from_les2.position
	if spawn == 108:
		spawn_position = $from_drotaverin.position
	if spawn == 109:
		spawn_position =$from_drotaverin.position
	if spawn == 110:
		spawn_position =$from_les_3.position
	if spawn == 118:
		spawn_position = $"from les 4".position
	if spawn == 113:
		spawn_position = $from_les_5.position
	
	if spawn == 119:
		spawn_position = $from_les_5.position
	if spawn == 111:
		spawn_position = $Marker_tutorial.position
	if spawn == 112:
		spawn_position = $to_les_2.position
	if spawn == 114:
		spawn_position = $from_les_3.position
		
	if spawn == 143:
		spawn_position = $from_les_14.position
	if spawn == 140:
		spawn_position = $from_les_16.position
	if spawn == 117:
		spawn_position = $"from les".position
	if spawn == 149:
		spawn_position = $from_les_11.position
	if spawn == 121:
		spawn_position = $from_les_5.position
	if spawn == 120: 
		spawn_position = $from_les_6.position
	if spawn == 122:
		spawn_position = $from_les_6.position
	if spawn == 123:
		spawn_position = $from_les_7.position
	if spawn == 124:
		spawn_position = $from_les_8.position
	if spawn == 125:
		spawn_position = $from_les_7.position
	if spawn == 126:
		spawn_position = $from_les_8.position
	if spawn == 127:
		spawn_position = $from_les_3.position
	if spawn == 128:
		spawn_position = $from_les_8.position
	if spawn == 129:
		spawn_position = $from_les_9.position
	if spawn == 130:
		spawn_position = $from_les_9.position
	if spawn == 131:
		spawn_position = $from_F1.position
	if spawn == 132:
		spawn_position = $from_F1.position
	if spawn == 133:
		spawn_position = $from_les_10.position
	if spawn == 134:
		spawn_position = $from_les_9.position
	if spawn == 135:
		spawn_position = $from_les_18.position
	if spawn == 136:
		spawn_position = $from_les_18.position
	if spawn == 137:
		spawn_position = $from_les_17.position
	if spawn == 138:
		spawn_position = $from_les_17.position
	if spawn == 139:
		spawn_position = $from_les_16.position
	if spawn == 141:
		spawn_position = $from_les_4.position
	if spawn == 142:
		spawn_position = $from_les_4.position
	if spawn == 144:
		spawn_position = $from_les_14.position
	if spawn == 145:
		spawn_position = $from_les_15.position
	if spawn == 146:
		spawn_position = $from_les_15.position
	if spawn == 147:
		spawn_position = $from_S.position
	if spawn == 148:
		spawn_position = $from_les_4.position
	if spawn == 150:
		spawn_position = $from_les_11.position
	if spawn == 151:
		spawn_position = $from_les_12.position
	if spawn == 152:
		spawn_position = $from_les_12.position
	if spawn == 153:
		spawn_position = $from_les_13.position
	if spawn == 154:
		spawn_position = $from_les_13.position
	if spawn == 155:
		spawn_position = $from_les_6.position
	if spawn == 156:
		spawn_position = $from_les_13.position
	if spawn == 157:
		spawn_position = $from_lianova_veza.position
	if spawn == 158:
		spawn_position = $from_lianova_veza.position
	if spawn == 159:
		spawn_position = $from_lianova_veza_II.position
	if spawn == 160:
		spawn_position = $from_mesto_na_lanach.position
	#if spawn == 123:
	#	spawn_position = $from_les_7.position
	if spawn == 161:
		spawn_position = $from_kvetiny.position
	if spawn == 162:
		spawn_position = $from_les_19.position
	if spawn == 163:
		spawn_position = $from_les_14_water.position
	if spawn == 164:
		spawn_position = $from_lianova_veza_II.position
	if spawn == 165:
		spawn_position = $from_lianova_veza_III.position
	
	
		
	player = $Player 

	if spawn_position:
		player.position = spawn_position
	
#func _process(delta: float) -> void:
#	#print(spawn_position)

func kill_dead():
	var ch = get_children()
	for i in ch:
		
		if i.is_in_group("Enemies"):
			level_enemies.append(i)
	##print('level enemeies: '+ str(level_enemies))
	#for i in range(level_enemies.size()):
	#	if !deadlist[i]:
		#	#print(level_enemies[i])
	#		level_enemies[i].die()
			
func npc_died(npc):
	for i in level_enemies.size():
		if level_enemies[i] == npc:
		#	#print('in level: '+str(level_enemies[i])+' '+str(npc))
			GameManager.register_dead_npc(level_name,i, respawn_time)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func open_known_treasures():
	var ch = get_children()
	#print(get_node('truhlica') )
	for i in ch:
		if i.is_in_group('tresures'):
			level_treasures.append(i)
		#	#print('treasure - ',i)
	##print('level treasures - ',level_treasures)
	for i in range(level_treasures.size()):
				if treasures[i]:
					level_treasures[i].opened()
			
func treasure_found(trs):
	
	for i in level_treasures.size():
		
		##print(trs)
		if level_treasures[i] == trs:
			
			GameManager.register_treasure(level_name, i)

func open_known_wisdom():
	var ch = get_children()
	for i in ch:
		if i.is_in_group('wisdom'):
			level_wisdom.append(i)
#	#print('level widom size: ', level_wisdom.size())
#	#print('wisdom gm: ', wisdom)
#	#print(GameManager.collected_wisdom)
	for i in range(level_wisdom.size()):
				if wisdom[i]:
					level_wisdom[i].opened()

func wisdom_found(wis):
	
	for i in level_wisdom.size():
		##print(level_wisdom[i])
		##print(wis)
		if level_wisdom[i] == wis:
			GameManager.register_wisdom(level_name, i)




func _on_cave_detector_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func unlock_barier(index):
	for c in get_children():
		if c.is_in_group('Unlockable_barier') and c.index == index:
			c.open()
			return
			
	
	
	
	
