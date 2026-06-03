extends StaticBody2D


var opened_bool=  false
var is_here = false
@export var key = 'okno'
@export var text = 'Čo vám pomôže vidieť cez každú stenu?'
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready() -> void:
	
	pass



func _input(event: InputEvent) -> void:
	#print(self)
	#print(!opened_bool)
	if (Input.is_action_just_pressed("go_to")  or Input.is_action_pressed("go_to")) and is_here and !opened_bool:
		get_parent().get_child(0).riddle_init(key, self, text)
		
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false

func open():
		$CollisionShape2D.disabled = true
		opened_bool = true
		$Sprite2D.hide()
		
