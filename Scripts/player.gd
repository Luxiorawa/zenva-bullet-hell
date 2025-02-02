class_name Player
extends CharacterBody2D

var speed := 75
var direction := Vector2(0, 1)

@onready var bullet_scene := preload("res://Scenes/Player/bullet.tscn")
@onready var sprite: Sprite2D = $Sprite2D
@onready var bullet_spawn: Marker2D = $BulletSpawn
@onready var bullet_pool: BulletPool = $Bullets

func _physics_process(_delta: float) -> void:
    var input_direction := Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).normalized()

    if input_direction.x > 0:
        sprite.frame = 1
        sprite.flip_h = false
        direction = input_direction
    elif input_direction.x < 0:
        sprite.frame = 1
        sprite.flip_h = true
        direction = input_direction
    elif input_direction.y > 0:
        sprite.frame = 0
        sprite.flip_v = false
        direction = input_direction
    elif input_direction.y < 0:
        sprite.frame = 2
        sprite.flip_v = false
        direction = input_direction

    var offset_from_sprite := 10
    bullet_spawn.position = direction * offset_from_sprite
    if Input.is_action_just_pressed("Shoot"):
        var bullet: Bullet = bullet_pool.pull_bullet_from_pool()
        bullet.velocity = direction * 140
        bullet.global_position = bullet_spawn.global_position
        bullet.show()
        bullet.set_process(true)
        bullet.set_physics_process(true)

    velocity = input_direction * speed

    move_and_slide()