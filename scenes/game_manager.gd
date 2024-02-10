extends Node2D

@onready var _timer = $Timer
@onready var clock = $Timer/Clock

func _on_ticker_current_hour(hour):
	print(hour)
	if hour == 11:
		game_end()
	
func _on_game_start():
	_timer.start_time()
	clock.autoplay = true
	clock.play()

func game_end():
	_timer.stop_time()
	print("game_end")
