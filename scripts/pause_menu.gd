extends Control

signal resume_game

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("resume_game")

func _on_resume_pressed() -> void:
	emit_signal("resume_game")

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
