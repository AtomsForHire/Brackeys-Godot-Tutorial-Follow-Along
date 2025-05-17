extends PlayerState

func enter() -> void:
	animated_sprite_2d.play("Jump")
	
func exit() -> void:
	pass
	
func physics_update(delta) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if player.is_on_wall_only():
		var wall_normal = player.get_wall_normal()
		var pressing_towards_wall: bool = false
		# If wall is on the player's left (normal.x is positive), player must press left (direction < 0)
		if wall_normal.x > 0.1 and direction < 0: # Using 0.1 to avoid issues with very slight normals
			pressing_towards_wall = true
		# If wall is on the player's right (normal.x is negative), player must press right (direction > 0)
		elif wall_normal.x < -0.1 and direction > 0:
			pressing_towards_wall = true
			
		if pressing_towards_wall:
			transitioned.emit(self, "WallState")
			return
		
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED) 
		
	# handle sprite dir
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	if player.is_on_floor():
		if direction == 0:
			transitioned.emit(self, "IdleState")
		else:
			transitioned.emit(self, "RunState")
