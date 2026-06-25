extends Node2D

@export var type = ''
@export var chance = 0.5

 
var enemy_chances = {
	'tolper':0.5,
	'dexamet':0.5,
	#'firing':0.05
}
var inst
var tolper = preload("res://scenes/enemies/Tolper.tscn")
var dexamet = preload("res://scenes/enemies/Dexamet.tscn")
var firing = preload("res://scenes/enemies/firing_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type == '':
		if randf() < chance:
			
			
			var roll = randf()
			var cumulative = 0.0
			for enemy in enemy_chances:
				cumulative += enemy_chances[enemy]
				if roll < cumulative:
					match_enemy(enemy)
					break
	else:
		match_enemy(type)
				
func match_enemy(type):
	#print('spawning: ',type)
	match type:
			'tolper':
				inst = tolper.instantiate()
				get_parent().call_deferred("add_child", inst)
				await get_tree().process_frame
				inst.global_position = global_position
			'dexamet':
				inst = dexamet.instantiate()
				get_parent().call_deferred("add_child", inst)
				await get_tree().process_frame
				inst.global_position = global_position
			'firing':
				inst = firing.instantiate()
				inst.global_position = global_position
				get_parent().add_child(inst)
func _process(delta: float) -> void:
	if inst:
		pass
		##print(inst.global_position)
