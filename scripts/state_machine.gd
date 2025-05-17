extends Node

var states: Dictionary = {}
var current_state: PlayerState 

@export var initial_state : PlayerState

# When loading the player, put all states under the StateMachine node into a dictionary
func _ready() -> void:
	for child in get_children():
		if child is PlayerState:
			states[child.name.to_lower()] = child
			
			# What does this line do?
			child.transitioned.connect(on_child_transition)
			
		if initial_state:
			initial_state.enter()
			current_state = initial_state

func _process(delta: float) -> void:
	# I'm not sure what would happen if we don't have this check here, 
	# I guess it makes sure the current_state is not a null PlayerState?
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())
	# Check if new state exists?
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state
		
