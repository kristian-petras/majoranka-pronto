class_name ClickableArea
extends Sprite2D

@export var id = "koko";
@export var nodeToPreview: Node2D;

@export var previewManager: PreviewManager;

var previewPosition: Vector2 = Vector2(500, 300);

# Called when the node enters the scene tree for the first time.
func _ready():
	previewPosition = get_viewport_rect().get_center()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# print("%s - %s" % [id, get_rect()]);

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var clickedOnThis = get_rect().has_point(to_local(event.position))
		if clickedOnThis and previewManager.try_lock_preview(self):
			print("showing preview of %s" % id)
			nodeToPreview.position = previewPosition
			nodeToPreview.visible = true
			nodeToPreview.top_level = true

func close_preview():
	nodeToPreview.visible = false
