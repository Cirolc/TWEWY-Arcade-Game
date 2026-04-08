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
			$Player/Camera3D.v_offset -= 0.1
		else:
			wait -= 1
	if $Player/Camera3D.v_offset < 0:
		$Player/Camera3D.v_offset = 0
		stop=true

	x = $Player/Camera3D.global_position[0]
	x = clamp(x,-3,3)
	$Player/Camera3D.global_position[0] = x
	if $Player.global_position[0] > 3 or $Player.global_position[0] < -3:
		if x < 0:
			x = -3
		else:
			x = 3
	$Player/Camera3D.global_position[0] = x
	z = $Player/Camera3D.global_position[2]
	z = clamp(z,-5,8)
	if $Player.global_position[2] > 1.5 or $Player.global_position[2] < -5:
		if z < 0:
			z = -5
		else:
			z = 8
	$Player/Camera3D.global_position[2] = z
