extends Node2D
class_name Barrel
var items = []
var drop_chances = {
'crystal ice':0.15, # 60
'giant snowflake':0.08,# += 24 =84
'frozen core': 0.04, # += 16 =100
'ash':0.15,
'fire in bottle':0.08,
'magma':0.04,
'wind feather':0.15,
'wind in bottle':0.08,
'wind metal': 0.04,

'dense wood':0.15,
'special leaves':0.08,
'strange fruit':0.04
}
# Called when the node enters the scene tree for the first time.
func destroy():
	$AnimationPlayer.play("destroy")
	var loot 

	if randf() >0.85:
		var roll = randf()
		var cumulative = 0.0
		for drop in drop_chances:
			cumulative += drop_chances[drop]
			if roll < cumulative:
				match drop:
					'crystal ice':
						loot = randi_range(7,11)
						GameManager.drop_ice[0] += loot
					'giant snowflake':
						loot = randi_range(3,5)
						GameManager.drop_ice[1] += loot
					'frozen core':
						loot = randi_range(1,2)
						GameManager.drop_ice[2] += loot
					'ash':
						loot = randi_range(7,11)
						GameManager.drop_fire[0] += loot
					'fire in bottle':
						loot = randi_range(3,5)
						GameManager.drop_fire[1] += loot
					'magma':
						loot = randi_range(1,2)
						GameManager.drop_fire[2] += loot
					'wind feather':
						loot = randi_range(7,11)
						GameManager.drop_wind[0] += loot
					'wind in bottle':
						loot = randi_range(3,5)
						GameManager.drop_wind[1] += loot
					'wind metal':
						loot = randi_range(1,2)
						GameManager.drop_wind[2] += loot	
					'dense wood':
						loot = randi_range(7,11)		
						GameManager.drop_earth[0] += loot
					'special leaves':
						loot = randi_range(3,5)
						GameManager.drop_earth[1] += loot
					'strange fruit':
						loot = randi_range(1,2)
						
						GameManager.drop_earth[2] += loot	
				GameManager.update_log_info('lucky barrel loot! +' + str(loot) + ' ' + drop)
				break
