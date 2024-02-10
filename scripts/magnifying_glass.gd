extends Node2D

const magnifyingRadius: float = 100.0;
const zoom: float = 0.7;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D/CanvasLayer/ColorRect.get_material().set_shader_parameter("zoom", zoom);
	$Camera2D/CanvasLayer/ColorRect.get_material().set_shader_parameter("radius", magnifyingRadius);
	$"Code-example".get_material().set_shader_parameter("radius", magnifyingRadius);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position();
	$Camera2D/CanvasLayer/ColorRect.get_material().set_shader_parameter("target", mousePos);
	$"Code-example".get_material().set_shader_parameter("target", mousePos);
