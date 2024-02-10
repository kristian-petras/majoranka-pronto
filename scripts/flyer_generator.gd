extends Node

var _product_scene = preload("res://scenes/product.tscn")
@onready var grid = $ColorRect/GridContainer

func _ready():
	randomize()
	var products = dir_contents("res://images/medication/")
	products.shuffle()
	products = products.slice(0, 40)
	for product in products:
		grid.add_child(product)
	
func dir_contents(path):
	var products = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if (file_name.ends_with("webp")):
					var texture = load(path + "/" + file_name)
					if texture:
						var product = _product_scene.instantiate()
						product.product_image.texture = texture
						product.product_image.scale = Vector2(0.1,0.1)
						product.product_name.text = file_name.split(".")[0]
						products.append(product)
					else:
						print("Failed to load texture from path: ", file_name)
				print("Found file: " + file_name)
			file_name = dir.get_next()
			
	else:
		print("An error occurred when trying to access the path.")
	return products
