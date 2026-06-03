extends Control

@onready var fill_max = $ColorRect.size.x

var fill_amount_health : float

func update_oxbar(oxygen, max_oxygen):
	fill_amount_health = (float(oxygen)/max_oxygen)*fill_max
	$ColorRect.size.x = fill_amount_health
