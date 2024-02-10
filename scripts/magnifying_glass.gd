extends Node2D

const magnifyingRadius: float = 100.0;
const zoom: float = 0.7;

var spookyness = 0;
var current_spookyness = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D/CanvasLayer/ColorRect.get_material().set_shader_parameter("zoom", zoom);
	$Camera2D/CanvasLayer/ColorRect.get_material().set_shader_parameter("radius", magnifyingRadius);
	$"letak-open".get_material().set_shader_parameter("radius", magnifyingRadius);
	
	$Timer.start_time();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position();
	
	$Camera2D/CanvasLayer/ColorRect.get_material().set_shader_parameter("target", mousePos);
	$"letak-open".get_material().set_shader_parameter("target", mousePos);
	
	if current_spookyness < spookyness:
		current_spookyness += delta
		_update_spookyness(current_spookyness)

func _on_ticker_current_hour(hour):
	spookyness = hour
	#if (spookyness >= 6):
		#spookyness = 12 - spookyness

func _update_spookyness(spooky):
	$Camera2D/CanvasLayer2/ColorRect2.get_material().set_shader_parameter("spookyness", spooky);
	
	var spooky_strength = (spooky / 6.0) + 1.0;
	$Camera2D/CanvasLayer/ColorRect.get_material().set_shader_parameter("strength_low", spooky_strength);
