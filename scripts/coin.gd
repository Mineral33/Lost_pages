extends Node2D

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("idle")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		##print(area.get_parent())
		GameManager.gain_coins(1)
		GameManager.score += 50
		queue_free()
