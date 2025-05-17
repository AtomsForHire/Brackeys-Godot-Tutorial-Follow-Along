extends PlayerState

# When entering jump state, modify the y velocity and immediately put into falling state
func enter():
	player.velocity.y = JUMP_VELOCITY
	player.get_node("JumpAudio").play()
	animated_sprite_2d.play("Jump")

func exit():
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	# I do this extra call so gravity is applied at every tick after jumping.
	# If I don't do this, there will be one tick where gravity is not applied
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	transitioned.emit(self, "FallingState")
	return
