class_name Snake
extends CharacterBody2D

var is_alive := true
var speed := 20

@onready var player: Player = $"../Player"
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(_delta: float) -> void:
    if is_alive:
        var direction: Vector2 = (player.global_position - self.global_position).normalized()
        velocity = speed * direction

        move_and_slide()

        if direction.x < 0:
            sprite.flip_h = false
        else:
            sprite.flip_v = true