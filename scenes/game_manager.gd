extends Node2D

@onready var _timer = $Timer
@onready var clock = $Timer/Clock

func _on_ticker_current_hour(hour):
	spookyness = hour
	print(hour)
	if hour == 11:
		game_end()
	
func _on_game_start():
	_timer.start_time()
	clock.autoplay = true
	clock.play()

func game_end():
	_timer.stop_time()
	print("game_end")

const magnifyingRadius: float = 80.0;
const zoom: float = 0.7; # between 0 and 1; 1 means no zoom and the lower you go the bigger the zoom

var spookyness = 0;
var current_spookyness = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D/CanvasLayer/BackgroundBlur.get_material().set_shader_parameter("zoom", zoom);
	$Camera2D/CanvasLayer/BackgroundBlur.get_material().set_shader_parameter("radius", magnifyingRadius);
	# $"letak-open".get_material().set_shader_parameter("radius", magnifyingRadius);
	_on_game_start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position();
	
	$Camera2D/CanvasLayer/BackgroundBlur.get_material().set_shader_parameter("target", mousePos);
	# $"letak-open".get_material().set_shader_parameter("target", mousePos);
	
	if current_spookyness < spookyness:
		current_spookyness += delta
		_update_spookyness(current_spookyness)


func _update_spookyness(spooky):
	$Camera2D/CanvasLayer2/SpookyEffects.get_material().set_shader_parameter("spookyness", spooky);
	
	var spooky_strength = (spooky / 6.0) + 1.0;
	$Camera2D/CanvasLayer/BackgroundBlur.get_material().set_shader_parameter("strength_low", spooky_strength);
