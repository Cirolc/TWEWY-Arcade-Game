extends Node

var wait = 51
var stop = false
var x = 0
var z = 0
var start = 295

func _process(_delta):
	if not stop:
		if wait == 0:
			$Top/Camera3D.global_position.z += 0.1
		else:
			wait -= 1
			$Top/Camera3D.global_position.y = 40
			$Top/Camera3D.global_position.z = 31.63
	if $Top/Camera3D.global_position.z > 39.2 and not stop:
		$Top/Camera3D.global_position.z = 39.2
		stop=true
	if stop:
		$Top/Camera3D.global_position = $Player.global_position
		$Top/Camera3D.global_position.y += 40
		$Top/Camera3D.global_position.z += 40

	x = $Top/Camera3D.global_position.x
	x = clamp(x,-4.6,4.6)
	if $Player.global_position.x > 4.6 or $Player.global_position.x < -4.6:
		if x < 0:
			x = -4.6
		else:
			x = 4.6
	$Top/Camera3D.global_position[0] = x
	z = $Top/Camera3D.global_position[2]
	z = clamp(z,-7,41.6)
	if $Player.global_position[2] < -5:
		if z > 2:
			z = 41.6
	$Top/Camera3D.global_position[2] = z
	if start != 0:
		start -= 1

func _on_floor_input_event(_camera, _event, click_position, _click_normal, _shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and start == 0:
		$Marker.transform.origin = click_position
		$Marker.visible = true
		$Marker.transform.origin[0] = clamp($Marker.transform.origin[0], -8, 8)
		$Marker.transform.origin[0] = clamp($Marker.transform.origin[0], $Top/Camera3D.global_position[0]-3.3, $Top/Camera3D.global_position[0]+3.3)
		$Marker.transform.origin[2] = clamp($Marker.transform.origin[2], -3, 4)
		$Marker.transform.origin[2] = clamp($Marker.transform.origin[2], $Top/Camera3D.global_position[2]-43.8, $Top/Camera3D.global_position[2]-37)
		click_position = ($Marker.transform.origin)
		$Player.direction = click_position
