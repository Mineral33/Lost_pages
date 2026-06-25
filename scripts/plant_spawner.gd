extends Node2D

var type = ['mata','salvia','divozel','slez','mak','skorocel','pupava','nevedza','cakanka','hluchavka','alchemilka','zihlava','trezalka','marinka','prvosienky','cesnak','konvalinky','jesienka']
@export var chance = 1
var textures_mata =       [preload("res://assets/decoration/bylinky/mata/mata_1.png"),             preload("res://assets/decoration/bylinky/mata/mata_2.png"),             preload("res://assets/decoration/bylinky/mata/mata_3.png")]
var textures_alchemilka = [preload("res://assets/decoration/bylinky/alchemilka/alchemilka_1.png"), preload("res://assets/decoration/bylinky/alchemilka/alchemilka_2.png"), preload("res://assets/decoration/bylinky/alchemilka/alchemilka_3.png")]
var textures_cakanka =    [preload("res://assets/decoration/bylinky/cakanka/cakanka_1.png"),       preload("res://assets/decoration/bylinky/cakanka/cakanka_2.png"),       preload("res://assets/decoration/bylinky/cakanka/cakanka_3.png")]
var textures_cesnak =     [preload("res://assets/decoration/bylinky/cesnak/cesnak_1.png"),         preload("res://assets/decoration/bylinky/cesnak/cesnak_2.png"),         preload("res://assets/decoration/bylinky/cesnak/cesnak_3.png")]
var textures_divozel =    [preload("res://assets/decoration/bylinky/divozel/divozel_1.png"),       preload("res://assets/decoration/bylinky/divozel/divozel_2.png"),       preload("res://assets/decoration/bylinky/divozel/divozel_3.png")]
var textures_hluchavka =  [preload("res://assets/decoration/bylinky/hluchavka/hluchavka_1.png"),   preload("res://assets/decoration/bylinky/hluchavka/hluchavka_2.png"),   preload("res://assets/decoration/bylinky/hluchavka/hluchavka_3.png")]
var textures_jesienka =   [preload("res://assets/decoration/bylinky/jesienka/jesienka_1.png"),     preload("res://assets/decoration/bylinky/jesienka/jesienka_2.png"),     preload("res://assets/decoration/bylinky/jesienka/jesienka_3.png")]
var textures_konvalinka = [preload("res://assets/decoration/bylinky/konvalinka/konvalinka_1.png"), preload("res://assets/decoration/bylinky/konvalinka/konvalinka_2.png"), preload("res://assets/decoration/bylinky/konvalinka/konvalinka_3.png")]
var textures_mak =        [preload("res://assets/decoration/bylinky/mak/mak_1.png"),               preload("res://assets/decoration/bylinky/mak/mak_2.png"),               preload("res://assets/decoration/bylinky/mak/mak_3.png")]
var textures_marinka =    [preload("res://assets/decoration/bylinky/marinka/marinka_1.png"),       preload("res://assets/decoration/bylinky/marinka/marinka_2.png"),       preload("res://assets/decoration/bylinky/marinka/marinka_3.png")]
var textures_nevadza =    [preload("res://assets/decoration/bylinky/nevadza/nevadza_1.png"),       preload("res://assets/decoration/bylinky/nevadza/nevadza_2.png"),       preload("res://assets/decoration/bylinky/nevadza/nevadza_3.png")]
var textures_prvosienka = [preload("res://assets/decoration/bylinky/prvosienka/prvosienka_1.png"), preload("res://assets/decoration/bylinky/prvosienka/prvosienka_2.png"), preload("res://assets/decoration/bylinky/prvosienka/prvosienka_3.png")]
var textures_pupava =     [preload("res://assets/decoration/bylinky/pupava/pupava_1.png"),         preload("res://assets/decoration/bylinky/pupava/pupava_2.png"),         preload("res://assets/decoration/bylinky/pupava/pupava_3.png")]
var textures_salvia =     [preload("res://assets/decoration/bylinky/salvia/salvia_1.png"),         preload("res://assets/decoration/bylinky/salvia/salvia_2.png"),         preload("res://assets/decoration/bylinky/salvia/salvia_3.png")]
var textures_skorocel =   [preload("res://assets/decoration/bylinky/skorocel/skorocel_1.png"),     preload("res://assets/decoration/bylinky/skorocel/skorocel_2.png"),     preload("res://assets/decoration/bylinky/skorocel/skorocel_3.png")]
var textures_slez =       [preload("res://assets/decoration/bylinky/slez/slez_1.png"),             preload("res://assets/decoration/bylinky/slez/slez_2.png"),             preload("res://assets/decoration/bylinky/slez/slez_3.png")]
var textures_trezalka =   [preload("res://assets/decoration/bylinky/trezalka/trezalka_1.png"),     preload("res://assets/decoration/bylinky/trezalka/trezalka_2.png"),     preload("res://assets/decoration/bylinky/trezalka/trezalka_3.png")]
var textures_zihlava =    [preload("res://assets/decoration/bylinky/zihlava/zihlava_1.png"),       preload("res://assets/decoration/bylinky/zihlava/zihlava_2.png"),       preload("res://assets/decoration/bylinky/zihlava/zihlava_3.png")]
var textures = []
var plant_chances = {
	"mata":       0.15,
	"alchemilka": 0.02,
	"cakanka":    0.02,
	"cesnak":     0.10,
	"divozel":    0.05,
	"hluchavka":  0.10,
	"jesienka":   0.05,
	"konvalinka": 0.04,
	"mak":        0.02,
	"marinka":    0.02,
	"nevadza":    0.02,
	"prvosienka": 0.02,
	"pupava":     0.15,
	"salvia":     0.04,
	"skorocel":   0.04,
	"slez":       0.04,
	"trezalka":   0.02,
	"zihlava":    0.10,
}


var is_here = false
var torn_off = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var sum = 0.0
	#for name in plant_chances:
	#	sum += plant_chances[name]
	##print(sum)
	

	if randf() < chance:
		$Sprite2D.visible = true
		$Area2D/CollisionShape2D.disabled = false
		
		var roll = randf()
		var cumulative = 0.0
		for plant in plant_chances:
			cumulative += plant_chances[plant]
			if roll < cumulative:
				type = plant
				match plant:
					"mata":       $Sprite2D.texture = textures_mata.pick_random()
					"alchemilka": $Sprite2D.texture = textures_alchemilka.pick_random()
					"cakanka":    $Sprite2D.texture = textures_cakanka.pick_random()
					"cesnak":     $Sprite2D.texture = textures_cesnak.pick_random()
					"divozel":    $Sprite2D.texture = textures_divozel.pick_random()
					"hluchavka":  $Sprite2D.texture = textures_hluchavka.pick_random()
					"jesienka":   $Sprite2D.texture = textures_jesienka.pick_random()
					"konvalinka": $Sprite2D.texture = textures_konvalinka.pick_random()
					"mak":        $Sprite2D.texture = textures_mak.pick_random()
					"marinka":    $Sprite2D.texture = textures_marinka.pick_random()
					"nevadza":    $Sprite2D.texture = textures_nevadza.pick_random()
					"prvosienka": $Sprite2D.texture = textures_prvosienka.pick_random()
					"pupava":     $Sprite2D.texture = textures_pupava.pick_random()
					"salvia":     $Sprite2D.texture = textures_salvia.pick_random()
					"skorocel":   $Sprite2D.texture = textures_skorocel.pick_random()
					"slez":       $Sprite2D.texture = textures_slez.pick_random()
					"trezalka":   $Sprite2D.texture = textures_trezalka.pick_random()
					"zihlava":    $Sprite2D.texture = textures_zihlava.pick_random()
				break


func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("go_to")  or Input.is_action_pressed("go_to")) and is_here and !torn_off:
		torn_off = true
		GameManager.plants[type] += 1
		$Sprite2D.hide()
		$Area2D/CollisionShape2D.disabled = true
		var player = get_parent().get_node('Player')
		match type:

		#	"alchemilka": $Sprite2D.texture = textures_alchemilka.pick_random()
	
			"cesnak":    player.heal(15)
			"jesienka":   player.take_damage(15,'m',' to nebol cesnak')
			"konvalinka":
				var max = player.max_health
				var tick_damage = 5
				var ticks = ceil(max/tick_damage)
				player.poison(tick_damage,0.1,ticks+2,' to nebol cesnak')
			"mak": player.randomize_bindings()
		
			#"mata":       $Sprite2D.texture = textures_mata.pick_random()
		
		#	"mak":        $Sprite2D.texture = textures_mak.pick_random()
		#	"marinka":    $Sprite2D.texture = textures_marinka.pick_random()
		
		#	"trezalka":   $Sprite2D.texture = textures_trezalka.pick_random()
		
		#	"nevadza":    $Sprite2D.texture = textures_nevadza.pick_random()
		#	"cakanka":    $Sprite2D.texture = textures_cakanka.pick_random()
		
		
		#	"pupava":     $Sprite2D.texture = textures_pupava.pick_random()
		
		#	"prvosienka": $Sprite2D.texture = textures_prvosienka.pick_random()
		#	"salvia":     $Sprite2D.texture = textures_salvia.pick_random()
		#	"skorocel":   $Sprite2D.texture = textures_skorocel.pick_random()
		#	"slez":       $Sprite2D.texture = textures_slez.pick_random()
		#	"divozel":    $Sprite2D.texture = textures_divozel.pick_random()
		#	"hluchavka":  $Sprite2D.texture = textures_hluchavka.pick_random()
		
		#	"zihlava":    $Sprite2D.texture = textures_zihlava.pick_random()
	
			
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true
		match type:
			"zihlava":    
				while is_here:
					#print(get_parent().get_node('Player'),' ',get_parent())
					get_parent().get_node('Player').take_damage(2,'m','Uprhleny zaživa')
					await get_tree().create_timer(0.5).timeout

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
