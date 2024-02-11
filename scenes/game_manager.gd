extends Node2D

@onready var _timer = $Timer
@onready var clock = $Timer/Clock
@export var objective: Label
@export var number_of_objectives: int
@export var chakra_sounds: Array[AudioStream]
var objective_products = []

@export var endgame: AudioStream
@export var ambient: AudioStreamPlayer
@onready var clock_player = $Timer/Clock

@onready var ap = $Camera2D/CanvasLayer3/AnimationPlayer
@onready var game_over_text = $Camera2D/CanvasLayer3/Label

var clicked_products = []

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
	ap.play("fade_to_black")
	chakra_player.stream = endgame
	clock_player.stop()
	ambient.stop()
	chakra_player.play()
	game_over_text.visible = true
	print("game_end")

const magnifyingRadius: float = 200.0;
const zoom: float = 0.5; # between 0 and 1; 1 means no zoom and the lower you go the bigger the zoom

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
	
	var spooky_strength = (spooky / 12.0) + 1.0;
	$Camera2D/CanvasLayer/BackgroundBlur.get_material().set_shader_parameter("strength_low", spooky_strength);


func _on_control_selected_products(products):
	var temp_products = products.duplicate()
	temp_products.shuffle()
	temp_products = temp_products.slice(0, number_of_objectives)
	for t in temp_products:
		objective_products.append(t.product_name.text)
	for product in objective_products:
		objective.text += product + "\n"
	objective_products.sort()

@export var chakra_player: AudioStreamPlayer

func _on_clicked_product(product):
	if product in clicked_products:
		if product in objective_products:
			print("cannot remove objective product " + product)
		else:
			print("removed product " + product)
			clicked_products.erase(product)
	else:
		print("added product " + product)
		clicked_products.append(product)
		if product in objective_products:
			chakra_player.stream = chakra_sounds[clicked_objective_products]
			chakra_player.play()
			clicked_objective_products += 1
	clicked_products.sort()
	print()
	print("Clicked products: ")
	for p in clicked_products:
		print(p)
		
	print()
	print("Objective products: ")
	for p in objective_products:
		print(p)
	if clicked_products == objective_products:
		game_end()
	
var clicked_objective_products = 0
