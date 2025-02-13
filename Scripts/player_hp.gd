class_name PlayerHP
extends ProgressBar

func _ready() -> void:
	max_value = Game.player_hp

func _process(_delta: float) -> void:
	value = Game.player_hp

