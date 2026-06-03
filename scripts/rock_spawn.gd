extends Area2D
var type = ''

@export var chance = 1
var textures_bauxit =    [preload("res://assets/decoration/sutre/bauxit/bauxit_1.png"),       preload("res://assets/decoration/sutre/bauxit/bauxit_2.png"),       preload("res://assets/decoration/sutre/bauxit/bauxit_3.png")]
var textures_malachite = [preload("res://assets/decoration/sutre/malachite/malachite_1.png"), preload("res://assets/decoration/sutre/malachite/malachite_2.png"), preload("res://assets/decoration/sutre/malachite/malachite_3.png")]
var textures_hematite =   [preload("res://assets/decoration/sutre/hematite/hematite_1.png"),     preload("res://assets/decoration/sutre/hematite/hematite_2.png"),     preload("res://assets/decoration/sutre/hematite/hematite_3.png")]
var textures_azurite =    [preload("res://assets/decoration/sutre/azurite/azurite_1.png"),       preload("res://assets/decoration/sutre/azurite/azurite_2.png"),       preload("res://assets/decoration/sutre/azurite/azurite_3.png")]
var textures_antimonite = [preload("res://assets/decoration/sutre/antimonite/antimonite_1.png"), preload("res://assets/decoration/sutre/antimonite/antimonite_2.png"), preload("res://assets/decoration/sutre/antimonite/antimonite_3.png")]
var textures_gold =       [preload("res://assets/decoration/sutre/gold/gold_1.png"),             preload("res://assets/decoration/sutre/gold/gold_2.png"),             preload("res://assets/decoration/sutre/gold/gold_3.png")]
var textures_silver =     [preload("res://assets/decoration/sutre/silver/silver_1.png"),         preload("res://assets/decoration/sutre/silver/silver_2.png"),         preload("res://assets/decoration/sutre/silver/silver_3.png")]
var textures_zincite =    [preload("res://assets/decoration/sutre/zincite/zincite_1.png"),       preload("res://assets/decoration/sutre/zincite/zincite_2.png"),       preload("res://assets/decoration/sutre/zincite/zincite_3.png")]
var textures_uvarovite =  [preload("res://assets/decoration/sutre/uvarovite/uvarovite_1.png"),   preload("res://assets/decoration/sutre/uvarovite/uvarovite_2.png"),   preload("res://assets/decoration/sutre/uvarovite/uvarovite_3.png")]
var textures_opal =       [preload("res://assets/decoration/sutre/opal/opal_1.png"),             preload("res://assets/decoration/sutre/opal/opal_2.png"),             preload("res://assets/decoration/sutre/opal/opal_3.png")]

var textures = []
var stone_chances = {
	'bauxit':0.35, # orange
	'hematite':0.3,# do cervena .5
	'malachite':0.02,# zelena
	'azurite':0.02,# modra
	'antimonite':0.05,# ....59
	'gold':0.07,#
	'silver':0.13,# .79
	'zincite':0.02, # red
	'uvarovite':0.02, # green
	'opal':0.02, # .85
}


var is_here = false
var torn_off = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var sum = 0.0
	#for name in stone_chances:
	#	sum += stone_chances[name]
	#print(sum)
	

	if randf() < chance:
		$Sprite2D.visible = true
		$CollisionShape2D.disabled = false
	
		var roll = randf()
		var cumulative = 0.0
		for stone in stone_chances:
			cumulative += stone_chances[stone]
			if roll < cumulative:
				type = stone
				match stone:
						"bauxit":
							$Sprite2D.texture = textures_bauxit.pick_random()
						"hematite":
							$Sprite2D.texture = textures_hematite.pick_random()
						"malachite":
							$Sprite2D.texture = textures_malachite.pick_random()
						"azurite":
							$Sprite2D.texture = textures_azurite.pick_random()
						"antimonite":
							$Sprite2D.texture = textures_antimonite.pick_random()
						"gold":
							$Sprite2D.texture = textures_gold.pick_random()
						"silver":
							$Sprite2D.texture = textures_silver.pick_random()
						"zincite":
							$Sprite2D.texture = textures_zincite.pick_random()
						"uvarovite":
							$Sprite2D.texture = textures_uvarovite.pick_random()
						"opal":
							$Sprite2D.texture = textures_opal.pick_random()
				break


func _input(event: InputEvent) -> void:
	#print(is_here, torn_off, Input.is_action_just_pressed("go_to"))
	if (Input.is_action_just_pressed("go_to")  or Input.is_action_pressed("go_to")) and is_here and !torn_off:
		torn_off = true
		GameManager.sutre[type] += 1
		$Sprite2D.hide()
		$CollisionShape2D.disabled = true
		
		#var player = get_parent().get_node('Player')
		#match type:
		

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
