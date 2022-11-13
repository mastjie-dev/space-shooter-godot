extends "res://Enemy.gd"

signal shoot_bullet(pos)

var velocity = Vector3(0, 0, 5)
var pos_a = Vector3(0, 0, -30)
var pos_b = Vector3(0, 0, -25)
var t = 0.0
var speed = 1.25

func ease_entrance(x):
	var c1 = 1.70158
	var c3 = c1 + 1

	return 1 + c3 * pow(x - 1, 3) + c1 * pow(x -1, 2)
	
func spawn():
	var x = rand_range(-18, 18)
	pos_a.x = x
	pos_b.x = x
	translation = pos_a

func _ready():
	hp = 3
	
func _physics_process(delta):
	t += delta * speed
	if t <= 1:
		var i = ease_entrance(t)
		translation = pos_a.linear_interpolate(pos_b, i)
	else:
		translation += velocity * delta

func _on_Timer_timeout():
	emit_signal("shoot_bullet", translation)
