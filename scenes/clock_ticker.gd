extends Sprite2D

@export var hour_tick_count = 8

var _current_hour = 0

var step = 3.75
var current_rotation = 180

# 0-11 throught the game
signal current_hour(hour)

func _on_tick(counter):
	current_rotation += step
	rotation_degrees = current_rotation
	if counter % hour_tick_count == 0:
		print("rotation and hour")
		print(current_rotation)
		print(_current_hour)
		current_hour.emit(_current_hour)
		_current_hour += 1

func _on_current_hour(hour):
	pass
