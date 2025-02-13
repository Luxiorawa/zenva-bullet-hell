class_name Snake
extends CharacterBody2D

var is_alive := true
var speed := 20
var health := 5

@onready var player: Player = $"../../Player"
@onready var sprite: Sprite2D = $Sprite2D
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var ai_bullet_spawn: Marker2D = $BulletSpawn
@onready var ai_bullet_pool: AIBulletPool = $Bullets

func _ready():
	animation.hide()
	progress_bar.max_value = health

func _physics_process(_delta: float) -> void:
	if is_alive:
		progress_bar.value = health
		var direction: Vector2 = (player.global_position - self.global_position).normalized()
		velocity = speed * direction

		move_and_slide()

		if direction.x < 0:
			sprite.flip_h = false
			ai_bullet_spawn.position = Vector2(-10, -11)
		else:
			sprite.flip_h = true
			ai_bullet_spawn.position = Vector2(10, -11)

	else:
		sprite.hide()
		progress_bar.hide()

func reset_mob(body: Node) -> void:
	var portal: Portal = get_parent()
	speed = 0
	is_alive = false
	animation.show()
	animation.play("death")
	await animation.animation_finished
	portal.reset_mob(body)

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if visible and body.visible:
			Game.player_hp -= 1


func _on_shoot_bullet_timeout():
	shoot_bullet()

func shoot_bullet() -> void:
	if self.visible && self.is_alive:
		var direction: Vector2 = (player.global_position - self.global_position).normalized()
		var ai_bullet: AIBullet = ai_bullet_pool.pull_bullet_from_pool()
		ai_bullet.velocity = direction * 140
		ai_bullet.global_position = ai_bullet_spawn.global_position
		ai_bullet.show()
		ai_bullet.set_process(true)
		ai_bullet.set_physics_process(true)
