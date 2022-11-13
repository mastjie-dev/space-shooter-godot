extends "res://Bullet.gd"

var speed = 8
var direction = Vector3.ZERO

func spawn(pos, dir):
	translation = pos + Vector3(0, 0, 1)
	direction = dir

func _on_EnemyBullet_body_entered(body):
	body.take_damage()
	
func _physics_process(delta):
	var velocity = direction * speed
	translation += velocity * delta
