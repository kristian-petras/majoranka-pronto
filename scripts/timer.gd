extends Node

signal time_feed(counter: int)

var _timer = false
var _ticks = 0
var _counter = 0

func start_time():
	print("Game time - started, counter: %s" % _counter)
	_timer = true

func stop_time():
	print("Game time - stopped, counter: %s" % _counter)
	_timer = false

func _process(delta):
	if _timer:
		_ticks += delta
	if _ticks > 1:
		_ticks = 0
		time_feed.emit(_counter)
		_counter += 1
