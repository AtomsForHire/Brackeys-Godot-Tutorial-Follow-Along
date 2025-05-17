extends Node
class_name PlayerState

# Signals states have changed
signal transitioned
const SPEED = 130.0
const JUMP_VELOCITY = -500.0

var player: CharacterBody2D
var animated_sprite_2d: AnimatedSprite2D

func _ready() -> void:
	player = get_tree().get_nodes_in_group("PlayerGroup")[0]
	animated_sprite_2d = player.get_node("AnimatedSprite2D")

# Define all the functions below in own dedicated script, per state

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
