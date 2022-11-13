extends "res://Bullet.gd"

var velocity = Vector3(0, 0, -30)
var offset = Vector3(0, 0, -2)

func spawn(pos):
	translation = pos + offset

func _physics_process(delta):
	translation += velocity * delta
