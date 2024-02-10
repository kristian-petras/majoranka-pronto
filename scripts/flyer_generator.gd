extends Node

@export var _product_list: Array[ProductData]
var _product_scene = preload("res://scenes/product.tscn")

func _ready():
	var i = 0
	for product in _product_list:
		var product_instance = _product_scene.instantiate()
		product_instance.product_data = product
		product_instance.position = Vector2(100 + 500*i, 200)
		add_child(product_instance)
		i += 1
	
