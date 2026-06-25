extends Node2D
var deadlist = GameManager.npc_deadlist('les')
var ch = get_children()
var level_enemies =[]
var level ='les'
var respawn_time = 1
var player
var spawn = GameManager.player_spawn
var spawn_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().current_scene.get_child(0).get_child(5).hide()
	await get_tree().create_timer(0.02).timeout
	kill_dead()
	if spawn == 103:
		spawn_position = $vchod.position
	if spawn == 104:
		spawn_position = $do_stromu.position
	if spawn == 106:
		spawn_position = $from_les2.position
	if spawn == 118:
		spawn_position = $"from les 4".position
	player = $Player
	#print(spawn_position)
	if spawn_position:
		player.position = spawn_position
	
#func _process(delta: float) -> void:
#	#print(spawn_position)

func kill_dead():
	
	
	var ch = get_children()
	for i in ch:
		
		if i.is_in_group("Enemies"):
			level_enemies.append(i)
	#print('level enemeies: '+ str(level_enemies))
	for i in range(level_enemies.size()):
		if !deadlist[i]:
			#print(level_enemies[i])
			level_enemies[i].die()
			
func npc_died(npc):
	
	for i in level_enemies.size():
		
		if level_enemies[i] == npc:
			#print('in level: '+str(level_enemies[i])+' '+str(npc))
			GameManager.register_dead_npc(level,i, respawn_time)
# Called every frame. 'delta' is the elapsed time since the previous frame.
