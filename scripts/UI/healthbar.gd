extends Control

@onready var fill_max = $ColorRect.size.x
var fill_amount_health : float 
var fill_amount_shield : float

func _ready():
	await get_tree().process_frame
	fill_max = $ColorRect.size.x
	if get_parent() is Player:
		fill_max = 32
func update_healthbar(health,max_health, shield := 0, max_shield:=1, shd:=true):
	
	
	#print('healthbar : ',health,' ',max_health, ' ', float(health)/max_health*fill_max, ' ',fill_max)
	fill_amount_health = (float(health)/max_health)*fill_max
	$ColorRect.size.x = floor(fill_amount_health)
	
	fill_amount_shield = (float(shield)/max_shield)*fill_max
	$ColorRect2.size.x = floor(fill_amount_shield)
	
	
		##print('shield '+str(shield)+' max '+ str(max_shield))
