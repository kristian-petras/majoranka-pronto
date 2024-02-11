extends Control

@export var product_image: TextureRect
@export var product_name: Label
@export var product_button: TextureButton


func _on_button_pressed():
	print(product_name.text)
	product_button.disabled = true
	print("aoaooa")
	pass # Replace with function body.
