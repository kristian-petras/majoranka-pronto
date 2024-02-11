extends Sprite2D

@export var hour_tick_count = 10

var _current_hour = 0

# 0-11 throught the game
signal current_hour(hour)

func _on_tick(counter):
	if counter % hour_tick_count == 0:
		current_hour.emit(_current_hour)
		_current_hour += 1

func _on_current_hour(hour):
	rotation_degrees = hour * 30
