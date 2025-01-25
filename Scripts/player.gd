class_name Player
extends CharacterBody2D

var speed := 75
var direction := Vector2(0, 1)

func _physics_process(_delta: float) -> void:
    var input_direction := Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).normalized()

    direction = input_direction

    if input_direction.x > 0:
        $Sprite2D.frame = 1
        $Sprite2D.flip_h = false
    elif input_direction.x < 0:
        $Sprite2D.frame = 1
        $Sprite2D.flip_h = true
    elif input_direction.y > 0:
        $Sprite2D.frame = 0
        $Sprite2D.flip_v = false
    elif input_direction.y < 0:
        $Sprite2D.frame = 2
        $Sprite2D.flip_v = false

    velocity = input_direction * speed

    move_and_slide()