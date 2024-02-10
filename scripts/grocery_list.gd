extends Node

# Example structure for groceries with name, image path, and price
var groceries = {
	"Fruits and Vegetables": [
		{"name": "Apples", "image": "res://images/apples.png", "price": 1.5},
		{"name": "Bananas", "image": "res://images/bananas.png", "price": 1.2},
		# Add more items...
	],
	"Protein Sources": [
		{"name": "Canned tuna", "image": "res://images/canned_tuna.png", "price": 3.0},
		{"name": "Eggs", "image": "res://images/eggs.png", "price": 2.5},
		# Add more items...
	],
	# Define other categories similarly...
}

func _ready():
	randomize()
		
func generate_groceries(size: int) -> Array:
	var all_items = []
	var random_groceries = []

	# Flatten the list of all groceries
	for category in groceries.keys():
		for item in groceries[category]:
			all_items.append(item)

	# Ensure we don't exceed the total number of unique items available
	var actual_size = min(size, all_items.size())

	while random_groceries.size() < actual_size:
		var item = all_items[randi() % all_items.size()]
		if item not in random_groceries:
			random_groceries.append(item)

	return random_groceries

	
func subset(list: Array, subset_size: int) -> Array:
	subset_size = min(subset_size, list.size())
	list.shuffle()
	return list.slice(0, subset_size)

