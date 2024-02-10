class_name PreviewManager
extends Node2D

signal preview_opened
signal preview_closed

var node_holding_preview: ClickableArea = null
	
func _input(event):		
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
		_release_lock()

func try_lock_preview(opened_node: ClickableArea):
	print("try lock")
	if node_holding_preview == null:
		node_holding_preview = opened_node
		preview_opened.emit()
		return true
		
	return false
	
func _release_lock():
	if node_holding_preview == null:
		return
	
	node_holding_preview.close_preview()
	node_holding_preview = null
