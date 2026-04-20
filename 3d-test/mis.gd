extends Node

func _ready():
	$ColorRect.visible = true
	$AnimationPlayer.play("start")
	$AnimationPlayer.animation_finished.connect(finish)

func finish(name):
	if name == "start":
		$ColorRect.visible = false

var timerNeku = 0
var hp = 882
var dmg = 0
var damageNeku = 1081

func _physics_process(delta: float):
	if Input.is_action_just_pressed("Down"):
		timerNeku = 20
		dmg = 20
		hp -= dmg
		if hp < 0:
			hp += dmg
			dmg = hp
			hp = 0
		damageNeku -= dmg
	if $Normal/Damage2.global_position.x != damageNeku:
		$Normal/Damage2.global_position.x -= 4
	if $Normal/Missing2.global_position.x != damageNeku and timerNeku == 0:
		$Normal/Missing2.global_position.x -= 2
	if timerNeku != 0:
		timerNeku -= 1
	$Normal/Damage2.global_position.x = clamp($Normal/Damage2.global_position.x, damageNeku, 1081)
	$Normal/Missing2.global_position.x = clamp($Normal/Missing2.global_position.x, damageNeku, 1081)
