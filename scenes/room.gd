extends TextureRect

var image1 = preload("res://images/room.webp")
var image2 = preload("res://images/room.png")

var current_image = 1

func _input(event):
	if event.is_action_pressed("ui_select"):  # 'ui_select' is the default action for the space bar
		# Toggle the image
		if current_image == 1:
			texture = image2
			current_image = 2
		else:
			texture = image1
			current_image = 1
