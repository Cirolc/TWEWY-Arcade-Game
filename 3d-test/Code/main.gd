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
			$Camera3D/Sprite3D.offset.y -= 2.664
		else:
			$Camera3D/Sprite3D.offset.y = 231.1
			wait -= 1
	if $Camera3D.h_offset > -2.5:
		$Camera3D.h_offset = -2.5
		$Camera3D/Sprite3D.offset.y = 0.25
		stop=true

	$Camera3D.global_position = $Player.global_position
	$Camera3D.global_position[1] += 10
	$Camera3D.global_position[2] += 10
	$Camera3D.rotation.y = 0

	x = $Camera3D.global_position[0]
	x = clamp(x,-4.6,4.6)
	if $Player.global_position[0] > 4.6 or $Player.global_position[0] < -4.6:
		if x < 0:
			x = -4.6
		else:
			x = 4.6
	$Camera3D.global_position[0] = x
	z = $Camera3D.global_position[2]
	z = clamp(z,-7,11.6)
	if $Player.global_position[2] < -5:
		if z > 2:
			z = 11.6
	$Camera3D.global_position[2] = z
	if start != 0:
		start -= 1

func _on_floor_input_event(_camera, _event, click_position, _click_normal, _shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and start == 0:
		$Marker.transform.origin = click_position
		$Marker.visible = true
		$Marker.transform.origin[0] = clamp($Marker.transform.origin[0], -8, 8)
		$Marker.transform.origin[2] = clamp($Marker.transform.origin[2], -3, 4)
		click_position = ($Marker.transform.origin)
		$Player.direction = click_position
