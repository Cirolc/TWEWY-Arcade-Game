extends MeshInstance3D

var comp
var dodge = 0
signal dodged
signal moved

func _process(delta: float):
	comp = get_node("../Player").global_position - global_position
	if comp[0] < 0:
		comp[0] -= comp[0] * 2
	if comp[2] < 0:
		comp[2] -= comp[2] * 2
	comp = comp[0] + comp[2]
	if comp <= 0.2 and not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		visible = false
		moved.emit()
	if comp >= 2.5 and dodge == 0 and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		dodged.emit()
		dodge = 90
	if dodge != 0:
		dodge -= 1
