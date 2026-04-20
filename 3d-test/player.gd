extends CharacterBody3D

@export var speed = 8
@export var Dodge_speed = 20
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var start = 325
var dodge = 0
var direction = Vector3.ZERO

func _physics_process(delta):
	if start == 0:
		velocity.y -= fall_acceleration * delta
		if direction:
			look_at(direction, Vector3.UP)
			rotation.x = 0
			rotation.z = 0
			$Sprite3D.rotation.y = -rotation.y
			if dodge != 0:
				if dodge < 38:
					velocity = -transform.basis.z * Dodge_speed
				else:
					velocity.x = 0
					velocity.z = 0
				$AnimationPlayer.current_animation="Dodge"
				dodge -= 1
			else:
				$AnimationPlayer.current_animation="Run"
				velocity = -transform.basis.z * speed
			if transform.origin.distance_to(direction) < .5:
				direction = Vector3.ZERO
				velocity = Vector3.ZERO
		elif dodge != 0:
			$AnimationPlayer.current_animation="Dodge"
			dodge -= 1
		else:
			$AnimationPlayer.current_animation="Idle"

		if direction.x < global_position[0]:
			$Sprite3D.flip_h = false
		elif direction.x > global_position[0]:
			$Sprite3D.flip_h = true

		for index in range(get_slide_collision_count()):
			var collision = get_slide_collision(index)
			if collision.get_collider() == null:
				continue
	else:
		start-=1
		if start < 163:
			$AnimationPlayer.current_animation="Start"
		if start == 0:
			$AnimationPlayer.current_animation="Idle"
	global_position.x = clamp(global_position.x, -10, 10)
	global_position.z = clamp(global_position.z, -5, 4)
	move_and_slide()

func _on_marker_moved():
	direction = Vector3.ZERO
	velocity.x = 0
	velocity.z = 0

func _on_marker_dodged() -> void:
	dodge = 46
