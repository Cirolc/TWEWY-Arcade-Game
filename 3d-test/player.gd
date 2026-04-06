extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO
var start = 156

func _input(event):
	if event is InputEventKey:
		if not event.pressed and start == 0:
			$AnimationPlayer.current_animation="Idle"

func _physics_process(delta):
	var direction = Vector3.ZERO

	if start == 0:
		if Input.is_action_pressed("Right"):
			direction.x += 1
			$AnimationPlayer.current_animation="Run"
		if Input.is_action_pressed("Left"):
			direction.x -= 1
			$AnimationPlayer.current_animation="Run"
		if Input.is_action_pressed("Down"):
			direction.z += 1
			$AnimationPlayer.current_animation="Run"
		if Input.is_action_pressed("Up"):
			direction.z -= 1
			$AnimationPlayer.current_animation="Run"
		if is_on_floor() and Input.is_action_just_pressed("Jump"):
			target_velocity.y = jump_impulse

		if direction.x < 0:
			$Sprite3D.flip_h = false
		elif direction.x > 0:
			$Sprite3D.flip_h = true

		if direction != Vector3.ZERO:
			direction = direction.normalized()
			$Pivot.basis = Basis.looking_at(direction)

		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed

		if not is_on_floor():
			target_velocity.y = target_velocity.y - (fall_acceleration * delta)

		for index in range(get_slide_collision_count()):
			var collision = get_slide_collision(index)

			if collision.get_collider() == null:
				continue

			if collision.get_collider().is_in_group("mob"):
				var mob = collision.get_collider()
				if Vector3.UP.dot(collision.get_normal()) > 0.1:
					mob.squash()
					target_velocity.y = bounce_impulse
					break
	else:
		start-=1
		$AnimationPlayer.current_animation="Start"
		if start == 0:
			$AnimationPlayer.current_animation="Idle"
	velocity = target_velocity
	move_and_slide()
