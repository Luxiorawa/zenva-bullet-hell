class_name Bullet
extends CharacterBody2D

func _process(_delta: float):
    self.rotation += 0.1
    move_and_slide()