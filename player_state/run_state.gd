extends PlayerState

# When entering run state play run animation
func enter() -> void:
	animated_sprite_2d.play("Run")
	
func exit() -> void:
	pass
	
func update(delta) -> void:
	pass
	
func physics_update(delta) -> void:
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "JumpState")
		return
		
	if not player.is_on_floor():
		transitioned.emit(self, "FallingState")
		return
		
	var direction := Input.get_axis("move_left", "move_right")
	
	# handle sprite dir
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		if is_zero_approx(player.velocity.x):
			transitioned.emit(self, "IdleState")
		return 
