extends Node

var VB = preload("res://VeteranBullet.tscn")

var dir = Vector3.BACK
var pos = Vector3(0, 0, -15)

func _ready():
	pass

func _unhandled_key_input(event):
	if Input.is_action_pressed("space"):
		pos.x = rand_range(-10, 10)
		var vb = VB.instance()
		vb.spawn(pos, dir)
		add_child(vb)
