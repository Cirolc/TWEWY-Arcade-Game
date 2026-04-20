extends Node

var wait = 151
var stop = false
var x = 0
var z = 0
var start = 325

func _process(_delta):
	if not stop:
		if wait == 0:
			$Camera3D.h_offset += 0.075
		else:
			wait -= 1
	if $Camera3D.h_offset > -2.5:
		$Camera3D.h_offset = -2.5
		stop=true

	$Camera3D.global_position = $Player.global_position
	$Camera3D.global_position[1] += 6.4
	$Camera3D.global_position[2] += 6.4
	$Camera3D.rotation.y = 0

	x = $Camera3D.global_position[0]
	x = clamp(x,-6.68,6.68)
	if $Player.global_position[0] > 6.68 or $Player.global_position[0] < -6.68:
		if x < 0:
			x = -6.68
		else:
			x = 6.68
	$Camera3D.global_position[0] = x
	z = $Camera3D.global_position[2]
	z = clamp(z,-7,8)
	if $Player.global_position[2] < -5:
		if z > 2:
			z = 8
	$Camera3D.global_position[2] = z
	if start != 0:
		start -= 1

func _on_floor_input_event(_camera, _event, click_position, _click_normal, _shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and start == 0:
		$Marker.transform.origin = click_position
		$Marker.visible = true
		$Marker.transform.origin[0] = clamp($Marker.transform.origin[0], -10, 10)
		$Marker.transform.origin[2] = clamp($Marker.transform.origin[2], -5, 4)
		click_position = ($Marker.transform.origin)
		$Player.direction = click_position
