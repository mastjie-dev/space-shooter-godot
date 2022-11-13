extends "res://Enemy.gd"

signal shoot_bullet(pos)

var posA = Vector3(15, 0, 0)
var posB = Vector3.ZERO
var posC = Vector3(-15, 0, 0)
var lerpA = Vector3.ZERO
var lerpB = Vector3.ZERO
var lerpC = Vector3.ZERO
var player_position = Vector3.ZERO
var t = 0.0

func spawn():
	hp = 2
	var i = floor(rand_range(0, 2))
	if i == 1:
		posA.x = -20
		posC.x = 20
	posA.z = rand_range(-35, -10)
	posC.z = rand_range(-35, -10)
	posB.x = rand_range(-5, 5)
	posB.z = rand_range(5, 15)
	
func get_player_position(pos):
	player_position = pos

func _physics_process(delta):
	t += delta * .1
	lerpA = posA.linear_interpolate(posB, t)
	lerpB = posB.linear_interpolate(posC, t)
	lerpC = lerpA.linear_interpolate(lerpB, t)
	translation = lerpC
	look_at(player_position, Vector3.UP)

func _on_Timer_timeout():
	emit_signal("shoot_bullet", translation)
