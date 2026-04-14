extends Node

var wait = 60
var stop = false
var x = 0
var z = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not stop:
		if wait == 0:
			$Camera3D.v_offset -= 0.1
		else:
			wait -= 1
	if $Camera3D.v_offset < 0:
		$Camera3D.v_offset = 0
		stop=true

	x = $Camera3D.global_position[0]
	x = clamp(x,-3,3)
	$Camera3D.global_position[0] = x
	if $Player.global_position[0] > 3 or $Player.global_position[0] < -3:
		if x < 0:
			x = -3
		else:
			x = 3
	$Camera3D.global_position[0] = x
	z = $Camera3D.global_position[2]
	z = clamp(z,-5,8)
	if $Player.global_position[2] > 1.5 or $Player.global_position[2] < -5:
		if z < 0:
			z = -5
		else:
			z = 8
	$Camera3D.global_position[2] = z

func _on_floor_input_event(camera, event, click_position, click_normal, shape_idx) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		$Marker.transform.origin = click_position
		$Marker.transform.origin[0] = clamp($Marker.transform.origin[0], -10, 10)
		$Marker.transform.origin[2] = clamp($Marker.transform.origin[2], -5, 4)
		click_position = ($Marker.transform.origin)
		$Player.direction = click_position
