extends CharacterBody3D

@export var speed = 10
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var start = 234

func _input(event):
	if event is InputEventKey:
		if not event.pressed and start == 0:
			$AnimationPlayer.current_animation="Idle"

var direction = Vector3.ZERO

func _physics_process(delta):
	if start == 0:
		velocity.y -= fall_acceleration * delta
		if direction:
			look_at(direction, Vector3.UP)
			rotation.x = 0
			$Sprite3D.rotation.y = -rotation.y
			$Camera3D.rotation.y = -rotation.y
			velocity = -transform.basis.z * speed
			if transform.origin.distance_to(direction) < .5:
				direction = Vector3.ZERO
				velocity = Vector3.ZERO

		if direction.x < 0:
			$Sprite3D.flip_h = false
		elif direction.x > 0:
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
