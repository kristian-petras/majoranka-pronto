extends Node

@onready var _grocery_manager = $"../GroceryManager"

func _ready():
	generate_day()
	
func generate_day():
	var all_groceries = _grocery_manager.generate_groceries(5)
	var required_groceries = _grocery_manager.subset(all_groceries, 3)
	print(all_groceries)
	print(required_groceries)


	
