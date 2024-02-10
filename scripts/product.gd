extends Node

@export var _product_data: ProductData

@export_category("Product elements")
@export var _product_image: Sprite2D
@export var _product_name: Label
@export var _product_price: Label

var max_width = 300
var max_height = 300

func _ready():
	_product_image.texture = _product_data.image
	_product_image.scale = Vector2(max_width, max_height) / _product_data.image.get_size()
	_product_name.text = _product_data.name
	_product_price.text = "%d.%d" % [_product_data.price / 100, _product_data.price % 100] 
