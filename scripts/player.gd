extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $StateMachine


func _physics_process(delta: float) -> void:
	if state_machine.current_state:
		state_machine._physics_process(delta)

	move_and_slide()
