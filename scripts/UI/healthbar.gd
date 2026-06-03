extends Control

@onready var fill_max = $ColorRect.size.x
var fill_amount_health : float
var fill_amount_shield : float
func update_healthbar(health,max_health, shield := 0, max_shield:=1, shd:=true):
	fill_amount_health = (float(health)/max_health)*fill_max
	$ColorRect.size.x = fill_amount_health
	
	fill_amount_shield = (float(shield)/max_shield)*fill_max
	$ColorRect2.size.x = fill_amount_shield
	
	
		#print('shield '+str(shield)+' max '+ str(max_shield))
