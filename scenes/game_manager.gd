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

@export var game_over_laugh: AudioStream
@export var game_over_win: AudioStream
@export var growl: AudioStream

var clicked_products = []

func _on_ticker_current_hour(hour):
	spookyness = hour
	print(hour)
	if hour == 12:
		game_end(false)
	
func _on_game_start():
	$Camera2D/CanvasLayer/BackgroundBlur.get_material().set_shader_parameter("zoom", zoom);
	$Camera2D/CanvasLayer/BackgroundBlur.get_material().set_shader_parameter("radius", magnifyingRadius);
	# $"letak-open".get_material().set_shader_parameter("radius", magnifyingRadius);
	_timer.start_time()
	clock.autoplay = true
	clock.play()

func game_end(evil):
	_timer.stop_time()
	ap.play("fade_to_black")
	clock_player.stop()
	ambient.stop()
	if clicked_products == objective_products:
		game_over_text.text = "You have successfully ordered your medicine."
		ambient.stream = game_over_win
		ambient.play()
	else:	
		chakra_player.stream = endgame
		chakra_player.play()
		ambient.stream = game_over_laugh
		ambient.play()
		if !evil:
			game_over_text.text = "You did not manage to order your medicine in time."
		else:
			game_over_text.text = "He did not like your behaviour."
	game_over_text.visible = true
	print("game_end")

var magnifyingRadius: float = 200.0;
const zoom: float = 0.5; # between 0 and 1; 1 means no zoom and the lower you go the bigger the zoom

var spookyness = 0;
var current_spookyness = 0;

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


@onready var product_control = $Camera2D/CanvasLayer/Flyer/Control/GridContainer
var product_children = []
var initialized = false

func _on_clicked_product(product):
	if !initialized:
		product_children.append_array(product_control.get_children())
		initialized = true
	if product in clicked_products:
		if product in objective_products:
			print("cannot remove objective product " + product)
		else:
			for p in product_children:
				if p.name == product:
					p.get_child(0).get_child(0).visible = false
			print("removed product " + product)
			clicked_products.erase(product)
	else:
		for p in product_children:
			if p.name == product:
				p.get_child(0).get_child(0).visible = true
		print("added product " + product)
		clicked_products.append(product)
		if product in objective_products:
			chakra_player.stream = chakra_sounds[clicked_objective_products]
			chakra_player.play()
			clicked_objective_products += 1
		else:
			spookyness += 1
			chakra_player.stream = growl
			chakra_player.play()
			magnifyingRadius = max(20, magnifyingRadius - 20)
			if magnifyingRadius == 20:
				game_end(true)
				return
			$Camera2D/CanvasLayer/BackgroundBlur.get_material().set_shader_parameter("radius", magnifyingRadius);
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
		game_end(false)
	
var clicked_objective_products = 0
