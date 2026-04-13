extends CharacterBody3D

@export var speed = 10
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO
var start = 234

func _input(event):
	if event is InputEventKey:
		if not event.pressed and start == 0:
			$AnimationPlayer.current_animation="Idle"

var direction = Vector3.ZERO

func _physics_process(delta):
	var mousePos = get_viewport().get_mouse_position()
	print(mousePos)
	var rayOrg:Vector3 = $Camera3D.project_ray_origin(mousePos)
	var rayNor:Vector3 = $Camera3D.project_ray_normal(mousePos)
	var Inters = Plane(Vector3.UP).intersects_ray(rayOrg,rayNor)
	if start == 0:
		if Inters and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			direction = Inters.x
			global_position.z = Inters.z
			global_position.x = clamp(global_position.x,-10,10)
			global_position.z = clamp(global_position.z,-5,4)
			$Marker.global_position.x = Inters.x
			$Marker.global_position.z = Inters.z
			$Marker.global_position.x = clamp(global_position.x,-10,10)
			$Marker.global_position.z = clamp(global_position.z,-5,4)

		if direction:
			velocity = -transform.basis.z * speed
			if transform.origin.distance_to(direction) < .5:
				direction = Vector3.ZERO
				velocity = Vector3.ZERO

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
	else:
		start-=1
		if start < 163:
			$AnimationPlayer.current_animation="Start"
		if start == 0:
			$AnimationPlayer.current_animation="Idle"
	velocity = target_velocity
	move_and_slide()
