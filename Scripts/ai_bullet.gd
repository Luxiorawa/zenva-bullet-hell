class_name AIBullet
extends CharacterBody2D

func _process(_delta: float):
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.visible and self.visible:
			Game.player_hp -= 1
			get_parent().reset_bullet(self)
