class_name Portal
extends Node2D

var mob_scene := preload("res://Scenes/Enemies/snake.tscn")
var pool_size := 10
var mob_pool := []
@onready var timer: Timer = $Timer

func _ready() -> void:
	for i in range(pool_size):
		add_mob_to_pool()

func add_mob_to_pool() -> Node:
	var mob = mob_scene.instantiate()
	mob.hide()
	mob_pool.append(mob)
	add_child(mob)
	return mob

func pull_mob_from_pool() -> Node:
	var mob: Node
	
	if mob_pool.is_empty():
		mob = add_mob_to_pool()
	else:
		mob = mob_pool[0]
		mob_pool.remove_at(0)

	return mob

func reset_mob(mob: Node) -> void:
	mob.global_position = Vector2(-10000, -10000)
	mob.is_alive = false

func _on_timer_timeout() -> void:
	var new_mob = pull_mob_from_pool()
	var random_vector := Vector2(randi_range(-50, 50), randi_range(-50, 50))
	new_mob.global_position = $Sprite2D.global_position + random_vector
	new_mob.is_alive = true
	new_mob.get_node("CollisionShape2D").disabled = false
	new_mob.set_process(true)
	new_mob.set_physics_process(true)
	new_mob.show()

