extends StaticBody2D

@export var kvetina = 1
@export var stonka_id = 1
var kvetiny = [ preload("res://assets/trees/kvetiny/flower_1.png"),preload("res://assets/trees/kvetiny/flower_4.png")]
var stonka = [ preload("res://assets/trees/kvetiny/stonka_1.png"), preload('res://assets/trees/kvetiny/stonka_2.png'), preload("res://assets/trees/kvetiny/stonka_3.png")]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = kvetiny[kvetina]
	$Stonka1.texture = stonka[stonka_id]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
