extends Area

signal hit(pos)
signal destroyed(pos)

var hp = 0
var offset := Vector3.BACK

func start_timer():
	$Timer.start()

func game_over():
	$Timer.stop()
	queue_free()
	
func _ready():
	add_to_group("enemies")

func _on_Enemy_area_entered(area):
	if area.is_in_group("player_bullet"):
		area.queue_free()
		emit_signal("hit", translation+offset)
		hp -= 1
		if hp == 0:
			emit_signal("destroyed", translation)
			queue_free()

func _on_Enemy_body_entered(body):
	body.take_damage()

func _on_VisibilityNotifier_screen_exited():
	queue_free()
