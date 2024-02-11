extends TextureButton

@export var list: Sprite2D

func _on_pressed():
	list.visible = true
	visible = false
