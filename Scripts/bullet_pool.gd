class_name BulletPool
extends Node

var bullet_scene := preload("res://Scenes/bullet.tscn")
var pool_size := 10
var bullet_pool := []

func _ready() -> void:
	for i in range(pool_size):
		add_bullet_to_pool()

func add_bullet_to_pool() -> Bullet:
	var bullet = bullet_scene.instantiate()
	bullet.set_process(false)
	bullet.set_physics_process(false)
	bullet.hide()
	bullet_pool.append(bullet)
	add_child(bullet)
	return bullet

func pull_bullet_from_pool() -> Bullet:
	var bullet: Bullet
	
	if bullet_pool.is_empty():
		bullet = add_bullet_to_pool()
	else:
		bullet = bullet_pool[0]
		bullet_pool.remove_at(0)

	return bullet