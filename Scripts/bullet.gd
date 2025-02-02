class_name Bullet
extends CharacterBody2D

func _process(_delta: float):
    self.rotation += 0.1
    move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Snake:
        if body.is_alive && body.visible and self.visible:
            body.queue_free()
            var bullet_pool: BulletPool = get_parent()
            bullet_pool.reset_bullet(self)