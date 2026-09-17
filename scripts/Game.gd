extends Node2D

const BallScene := preload("res://scenes/Ball.tscn")
const CircleScene := preload("res://scenes/Circle.tscn")
const ParticleBurstScene := preload("res://scenes/ParticleBurst.tscn")

const COLOR_PALETTE: Array[Color] = [
	Color(1.0, 1.0, 0.956863),
	Color(1.0, 0.870588, 0.0),
]

@onready var touch_overlay: Sprite2D = $TouchOverlay
@onready var score_label: Label = $ScoreLabel
@onready var game_layer: Node2D = $GameLayer
@onready var score_sound: AudioStreamPlayer = $ScoreSound
@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var death_zone: Area2D = $DeathZone

var started: bool = false
var points: int = 0
var circles: Array[Circle] = []
var ball: Ball = null

var _tap_consumed_this_frame: bool = false

func _ready() -> void:
	score_label.visible = false
	score_label.text = "0"
	death_zone.area_entered.connect(_on_death_zone_area_entered)

func _process(_delta: float) -> void:
	_tap_consumed_this_frame = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_R:
		get_tree().reload_current_scene()
		return

	var is_tap := false
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_tap = true
	elif event is InputEventScreenTouch and event.pressed:
		is_tap = true

	if not is_tap or _tap_consumed_this_frame:
		return
	_tap_consumed_this_frame = true

	if not started:
		_start_game()
	else:
		for c in circles:
			c.on_tap()

func _start_game() -> void:
	started = true
	touch_overlay.visible = false
	points = 0
	score_label.text = "0"
	score_label.visible = true

	var palette := COLOR_PALETTE.duplicate()
	palette.shuffle()
	var color_a: Color = palette[0]
	var color_b: Color = palette[1]

	# Sumar min_x y Restar max_x para ajustar valores a 32
	var circle_up := _make_circle(Vector2(160.0, 480.0), 16.0, -16.0, 160, 352, color_b)
	var circle2_up := _make_circle(Vector2(352.0, 480.0), 16.0, -16.0, 352, 544, color_a)
	var circle_d := _make_circle(Vector2(352.0, 992.0), -16.0, 16.0, 160, 352, color_b)
	var circle_d2 := _make_circle(Vector2(544.0, 992.0), -16.0, 16.0, 352, 544, color_a)
	circles = [circle_up, circle2_up, circle_d, circle_d2]

	ball = BallScene.instantiate()
	ball.position = Vector2(352.0, 736.0)
	game_layer.add_child(ball)
	ball.setup(circle_up, circle2_up, circle_d, circle_d2, color_a, color_b)
	ball.scored.connect(_on_ball_scored)
	ball.died.connect(_on_ball_died)

func _make_circle(pos: Vector2, first_tap: float, second_tap: float, min_x: float, max_x: float, tint: Color) -> Circle:
	var c: Circle = CircleScene.instantiate()
	c.position = pos
	c.first_tap_speed = first_tap
	c.second_tap_speed = second_tap
	c.min_x = min_x
	c.max_x = max_x
	c.modulate = tint
	game_layer.add_child(c)
	return c

func _on_ball_scored() -> void:
	points += 1
	score_label.text = str(points)
	score_sound.play()

func _on_death_zone_area_entered(area: Area2D) -> void:
	if area == ball:
		ball.die_out_of_bounds()

func _on_ball_died(color: Color, world_position: Vector2) -> void:
	death_sound.play()
	var burst := ParticleBurstScene.instantiate()
	add_child(burst)
	burst.position = world_position
	burst.color = color

	Globals.points = points

	get_tree().create_timer(100.0 / 60.0).timeout.connect(_go_to_game_over)

func _go_to_game_over() -> void:
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
