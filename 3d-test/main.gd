extends Node

var wait = 60

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if wait == 0:
		$Player/Camera3D.v_offset -= 0.1
	else:
		wait -= 1
	if $Player/Camera3D.v_offset < 0:
		$Player/Camera3D.v_offset = 0
