extends Node2D
##
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
'''
čaje suma počet/šanca = 1500
upokojujuci - mata x75, prvosienka x10, trezalka x10, marinka x10
dýchací -  divozel 20x, slez 15x, skorocel 10x, hluchavka 20x, salvia x10
detox? - žihlava 35x, pupava 75x, alchemilka 10x, cesnak x15
povzbudivý - čakanka x15, nevädza x15,

??? - mak, marinka, trezalka, lastovicnik
'''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.




var is_here = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("go_to") and is_here or Input.is_action_pressed("go_to") and is_here:
		print('open')
		get_parent().get_child(0).caj_init()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
