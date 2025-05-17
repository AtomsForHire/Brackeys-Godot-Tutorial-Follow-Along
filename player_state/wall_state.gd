extends PlayerState

func enter() -> void:
	animated_sprite_2d.play("Jump")
	player.velocity.y = 0
	
func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
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
				if Input.is_action_just_pressed("jump"):
					player.velocity.y = JUMP_VELOCITY 
					player.velocity.x = wall_normal.x * 300
				else:
					player.velocity += 0.1 * player.get_gravity() * delta
				return

	if not player.is_on_floor():
		transitioned.emit(self, "FallingState")
		
	if player.is_on_floor():
		if direction == 0:
			transitioned.emit(self, "IdleState")
		else:
			transitioned.emit(self, "RunState")
		
