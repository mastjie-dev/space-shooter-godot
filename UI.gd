extends Control

signal play_button_pressed

var score = 0

func add_score():
	score += 1
	$LiveScore.text = "Score: %s" % score

func game_over():
	$LiveScore.hide()
	$LiveScore.text = "Score: 0"
	$Retry.show()
	$Retry/FinalScore.text = "Final Score: %s" % score
	$Retry/FinalScore.show()

func _on_Button_pressed():
	$Retry.hide()
	$LiveScore.show()
	emit_signal("play_button_pressed")
