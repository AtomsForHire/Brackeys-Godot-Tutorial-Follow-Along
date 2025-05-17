extends StaticBody2D

var num_coins: int
@onready var coin_sound: AudioStreamPlayer2D = $CoinSound
@onready var game_manager: Node = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	num_coins = randi_range(3, 5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if num_coins > 0:
		if body.is_in_group("PlayerGroup"):
			coin_sound.play()
			game_manager.add_point()
			num_coins -= 1
