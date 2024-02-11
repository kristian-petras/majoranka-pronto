class_name ClickableArea
extends Sprite2D

@export var id = "koko";
@export var nodeToPreview: Node2D;
@export var node_to_hide: Node2D

@export var previewManager: PreviewManager;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# print("%s - %s" % [id, get_rect()]);

func _input(event):
	if event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
		var clickedOnThis = get_rect().has_point(to_local(event.position))
		if clickedOnThis and previewManager.try_lock_preview(self):
			print("showing preview of %s" % id)
			nodeToPreview.visible = true
			nodeToPreview.top_level = true
			if node_to_hide != null:
				node_to_hide.visible = false

func close_preview():
	if node_to_hide != null:
		node_to_hide.visible = true
	nodeToPreview.visible = false
