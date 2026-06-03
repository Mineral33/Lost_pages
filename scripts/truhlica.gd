extends Node2D
@export var gold = 250
var player = null
var opened_bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("go_to") and player != null and !opened_bool:
		get_parent().treasure_found(self)
		GameManager.gold += gold
		GameManager.update_log_info(' You found treasure worth'+str(gold)+' gold!')
		opened()
func _on_area_2d_area_entered(area: Area2D) -> void:	
	if area.get_parent() is Player:
		player = area.get_parent()
		
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		player = null
		
func opened():
	$AnimationPlayer.play('open')
	opened_bool = true
