class_name Product
extends Node

@export var product_data: ProductData

@export_category("Product elements")
@export var _product_image: TextureRect
@export var _product_name: Label
@export var _product_price: Label

func _ready():
	_product_image.texture = product_data.texture
	_product_name.text = product_data.name
	var first_part = product_data.price / 100
	var second_part = product_data.price % 100
	if (second_part < 10):
		second_part = "0%s" % second_part 
	_product_price.text = "%s.%s CZK" % [first_part, second_part] 
