extends Sprite2D


@export var variants: Array[Texture2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees = randi_range(-30,30)
	texture = variants[randi_range(0, variants.size() - 1)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
