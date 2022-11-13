extends Area

func game_over():
	queue_free()

func _ready():
	add_to_group("enemies")

func _on_VisibilityNotifier_screen_exited():
	queue_free()
