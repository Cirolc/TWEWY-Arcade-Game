extends Node

func _ready():
	$ColorRect.visible = true
	$AnimationPlayer.play("start")

var timerNeku = 0
var hp = 882
var dmg = 0
var damageNeku = 1081

func _physics_process(_delta):
	if Input.is_action_just_pressed("Down"):
		timerNeku = 20
		dmg = 20
		hp -= dmg
		if hp < 0:
			hp += dmg
			dmg = hp
			hp = 0
		damageNeku -= dmg
	if $Normal/Down/Damage.global_position.x != damageNeku:
		$Normal/Down/Damage.global_position.x -= 4
	if $Normal/Down/Missing.global_position.x != damageNeku and timerNeku == 0:
		$Normal/Down/Missing.global_position.x -= 2
	if timerNeku != 0:
		timerNeku -= 1
	$Normal/Down/Damage.global_position.x = clamp($Normal/Down/Damage.global_position.x, damageNeku, 1081)
	$Normal/Down/Missing.global_position.x = clamp($Normal/Down/Missing.global_position.x, damageNeku, 1081)
