extends Sprite2D

var textures = [preload("res://assets/decoration/torch/torch0000.png")
,preload("res://assets/decoration/torch/torch0001.png"),
preload("res://assets/decoration/torch/torch0002.png"),
preload("res://assets/decoration/torch/torch0003.png"),
preload("res://assets/decoration/torch/torch0004.png"),]


func _on_timer_timeout() -> void:
	$".".texture = textures.pick_random()
	$Timer.start(randf_range(0.7,1.5))
