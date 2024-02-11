extends Node

var _product_scene = preload("res://scenes/product.tscn")
@onready var grid = $ColorRect/GridContainer

signal selected_products(products)

const medication_path = "res://images/medication"

func _ready():
	randomize() 
	
	var medication_resources = _scan_for_images(medication_path)	
	var products = medication_resources\
		.map(func (x): return _load_product(medication_path, x))\
		.filter(func (x): return x != null)

	print_debug("Loaded %d products" % products.size())

	products.shuffle()
	products = products.slice(0, 40)
	selected_products.emit(products)
	for product in products:
		grid.add_child(product)

func array_unique(array: Array) -> Array:
	var unique: Array = []

	for item in array:
		if not unique.has(item):
			unique.append(item)
		
	return unique

func _scan_for_images(path):
	var dir = DirAccess.open(path)
	if !dir:
		return []
		
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	var files = []
	while file_name != "":
		if dir.current_is_dir():
			continue
		
		if file_name.ends_with(".import"):
			file_name = file_name.replace(".import", "")
			
		files.append(file_name)
		file_name = dir.get_next()
	
	return array_unique(files)

func _load_product(base_path, filename):
	var pathToTexture = base_path + '/' + filename
	
	var texture = load(pathToTexture)
	if !texture:
		return null
	
	var product = _product_scene.instantiate()
	product.product_image.texture = texture
	product.product_image.scale = Vector2(0.1,0.1)
	product.product_button.scale = Vector2(0.1,0.1)
	product.product_button.texture_normal = texture
	product.product_name.text = filename.split(".")[0]

	return product
