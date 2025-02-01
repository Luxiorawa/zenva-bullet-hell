class_name BulletPool
extends Node

var bullet_scene := preload("res://Scenes/bullet.tscn")
var pool_size := 10
var bullet_pool := []

func _ready() -> void:
	for i in range(pool_size):
		pass