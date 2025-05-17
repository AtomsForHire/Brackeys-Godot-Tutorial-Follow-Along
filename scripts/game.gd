extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
var current_pause_menu : Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu()
		
func pause_menu():
	var pause_menu_scene = load("res://scenes/pause_menu.tscn")
	current_pause_menu = pause_menu_scene.instantiate()
	
	
	if current_pause_menu.has_signal("resume_game"):
		current_pause_menu.connect("resume_game", Callable(self, "_on_resume_game"))
	else:
		print("Does not have signal resume_game")
	
	canvas_layer.add_child(current_pause_menu)
	get_tree().paused = true


func _on_resume_game() -> void:
	if is_instance_valid(current_pause_menu):
		current_pause_menu.queue_free()
		current_pause_menu = null
	
	get_tree().paused = false
