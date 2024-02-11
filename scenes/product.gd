class_name Product
extends Control

@export var product_name: Label
@export var product_button: TextureButton

signal test(a)

func _on_button_pressed():
	test.emit(product_name.text)
