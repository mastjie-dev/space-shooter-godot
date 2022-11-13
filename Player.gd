extends KinematicBody

signal player_position(pos)
signal player_hit(pos)
signal player_destroyed(pos)
signal bullet_fired

var PlayerBullet = preload("res://PlayerBullet.tscn")

var speed = 20
var hp = 0
var velocity = Vector3.ZERO

func start():
	hp = 5
	translation = Vector3(0, 0, 24)
	show()
	$Timer.start()

func take_damage():
	hp -= 1
	emit_signal("player_hit", translation)
	if hp == 0:
		emit_signal("player_destroyed", translation)
		$Timer.stop()
		hide()

func _physics_process(_delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity = move_and_slide(velocity, Vector3.UP)
	
	emit_signal("player_position", translation)

func _on_Timer_timeout():
	var bullet = PlayerBullet.instance()
	bullet.spawn(translation)
	get_parent().add_child(bullet)
	emit_signal("bullet_fired")
