extends Node2D
class_name cerv
var max_health = 250 
var max_shield = 500

var active = 1
var history = []
var segment_spacing = 40  # pixels between segments
var following = false
@onready var head = $hlava 
@onready var segments = [
	$hlava,
	$"červ-segmet-2",
	$"Červ-telo",
	$"Červ-telo2",
	$"Červ-telo3",
	$"Červ-telo4",
	$"Červ-zadok"
]



func _physics_process(delta: float) -> void:
	
		var current_dir = head.current_dir
		

		# record head position every frame
		#history.push_front(global_position)
		
		# keep history from growing forever
		#var max_history = segment_spacing * segments.size() * 2
		#if history.size() > max_history:
		#	history.pop_back()
		
		
		# head faces movement direction
		
		#segments[0].global_position = $hlava.global_position
		segments[0].rotation = current_dir.angle()

		# each segment follows the one in front at fixed distance
		for i in range(1, segments.size()):
			var front = segments[i - 1]
			var seg = segments[i]
			var diff = seg.global_position - front.global_position
		#	print(front.name, ' ',seg.name,' ', diff)
			if diff.length() > segment_spacing:
				seg.global_position = front.global_position + diff.normalized() * segment_spacing
			seg.rotation = (front.global_position - seg.global_position).angle()

		$"Červ-zadok".scale.x = -1


func _on_player_follow_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		following = true
func _on_player_follow_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		following = false

func _on_atttack_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().take_damage(25,'m','Kto bude teraz obohacovať kompost?')
		
			
func die():
	GameManager.update_log_info('červ defeated + 500 gold')
	GameManager.gold += 500
	get_parent().npc_died(self)
	#print('info to level '+ str(get_parent().name))# tell game manager that this died
	queue_free()
