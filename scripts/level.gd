extends Node

@onready var _grocery_manager = $"../GroceryManager"
@onready var _timer = $"../Timer"

func _ready():
	_timer.time_feed.connect(_on_tick)
	_timer.start_time()
	generate_day()
	
func generate_day():
	var all_groceries = _grocery_manager.generate_groceries(5)
	var required_groceries = _grocery_manager.subset(all_groceries, 3)
	print(all_groceries)
	print(required_groceries)
	
	
func _on_tick(counter):
	print("hoggi %s" % counter)
	pass

	
