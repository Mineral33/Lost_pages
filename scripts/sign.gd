extends Sprite2D


@export var text = ''
func _on_area_2d_mouse_entered() -> void:
	$RichTextLabel.text = text
	$RichTextLabel.show()
func _on_area_2d_mouse_exited() -> void:

	$RichTextLabel.hide()
