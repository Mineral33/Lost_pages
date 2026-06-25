extends ColorRect

var dragging := false
var drag_offset := Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start dragging if clicked inside this control
				dragging = true
				drag_offset = event.position
			else:
				# Stop dragging on release
				dragging = false

	elif event is InputEventMouseMotion:
		if dragging:
			# Move the control with the mouse
			$".".position += event.relative



@onready var fill_max = $"../health_ui/health".size.x
var fill_amount : float

func update_healthbar(health,max_health, shield := 0, max_shield:=1,shd := false):
	fill_amount = (float(health)/max_health)*fill_max
	$"../health_ui/health".size.x = fill_amount
	$"../health_ui/health/health_ui_Label".text = str(round(health))+" / "+str(round(max_health))
	if shd:
		$"../health_ui/health".show()
		fill_amount = (float(shield)/max_shield)*fill_max
		$"../health_ui/shield".size.x = fill_amount
		$"../health_ui/shield/shield_ui_Label".text = str(round(shield))+ ' / ' + str(round(max_shield))
		
@export var player: CharacterBody2D
@export var level_width: float = 8200.0   # total level width in pixels
@export var level_height: float = 3200.0   # total level height in pixels

@onready var dot = $"../minimap/dot"  # the player dot
func _ready() -> void:

	if name== 'minimap' and get_parent().get_parent().name != 'main':
		#print(get_parent().get_parent().get_child(1))
		player = get_parent().get_parent().get_child(1)
			
func _process(_delta):
	if name == 'minimap'and get_parent().get_parent().name != 'main':
		var minimap_size = size  # size of this Control node
		var x_offset = get_parent().x_offset
		var y_offset = get_parent().y_offset
		
	# Scale player world position to minimap size
		var mapped_x = ((player.global_position.x+x_offset) / level_width) * minimap_size.x
		var mapped_y = ((player.global_position.y+y_offset) / level_height) * minimap_size.y
		
		dot.position = Vector2(mapped_x, mapped_y)
