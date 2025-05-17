extends PlayerState
class_name IdleState

# When entering idle state, play the idle animation
func enter():
	animated_sprite_2d.play("Idle")

# No actions needed at the moment when exiting idle state
func exit():
	pass
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transitioned.emit(self, "JumpState")
		return
	
	if not player.is_on_floor():
		transitioned.emit(self, "FallingState")
		
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		transitioned.emit(self, "RunState")
		return
