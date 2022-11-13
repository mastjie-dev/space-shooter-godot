extends "res://Bullet.gd"

var speed = 6
var velocity = Vector3.ZERO

func spawn(pos, dir):
	var offset = dir * 2
	translation = pos + offset
	velocity = dir * speed
	
func _physics_process(delta):
	translation += velocity * delta

func _on_VeteranBullet_body_entered(body):
	body.take_damage()
