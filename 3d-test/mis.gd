extends Node

func _ready():
	$ColorRect.visible = true
	$AnimationPlayer.play("start")
	$AnimationPlayer.animation_finished.connect(finish)

func finish(name):
	if name == "start":
		$ColorRect.visible = false
