class_name ClickableArea
extends Sprite2D

@export var id = "koko";
@export var nodeToPreview: Control;

@export var previewManager: PreviewManager;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# print("%s - %s" % [id, get_rect()]);

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var clickedOnThis = get_rect().has_point(to_local(event.position))
		if clickedOnThis and previewManager.try_lock_preview(self):
			print("showing preview of %s" % id)
			nodeToPreview.visible = true
			nodeToPreview.top_level = true

func close_preview():
	nodeToPreview.visible = false
