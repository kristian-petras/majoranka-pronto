extends TextureButton

@export var clickable: Array[ClickableArea]
@export var list: Sprite2D
@export var blur: ColorRect
@export var ap: AnimationPlayer
@onready var world = $".."

func _on_pressed():
	for c in clickable:
		c.is_enabled = true
	visible = false
	ap.play("scene_transition")



func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "scene_transition"):
		blur.visible = true
		world._on_game_start()
