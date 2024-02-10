class_name PreviewManager
extends Node2D

var node_holding_preview: ClickableArea = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):		
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
		_release_lock()

func try_lock_preview(opened_node: ClickableArea):
	print("try lock")
	if node_holding_preview == null:
		node_holding_preview = opened_node
		return true
		
	return false
	
func _release_lock():
	if node_holding_preview == null:
		return
	
	node_holding_preview.close_preview()
	node_holding_preview = null
