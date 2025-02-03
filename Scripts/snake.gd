class_name Snake
extends CharacterBody2D

var is_alive := true
var speed := 20
var health := 5

@onready var player: Player = $"../../Player"
@onready var sprite: Sprite2D = $Sprite2D
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

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
		else:
			sprite.flip_h = true
	else:
		sprite.hide()
		progress_bar.hide()

func reset_mob(body: Node) -> void:
	var portal: Portal = get_parent()
	animation.show()
	animation.play("death")
	await animation.animation_finished
	portal.reset_mob(body)

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if visible and body.visible:
			Game.player_hp -= 1
