extends Node2D

@onready var points_label: Label = $PointsLabel
@onready var best_label: Label = $BestLabel
@onready var retry_button: TextureButton = $RetryButton
@onready var exit_button: TextureButton = $ExitButton

var _tap_consumed_this_frame: bool = false

func _ready() -> void:
	points_label.text = str(Globals.points)

	var is_new_best := Globals.register_score(Globals.points)
	if is_new_best:
		best_label.text = "NEW BEST!"
	else:
		best_label.text = "BEST " + str(Globals.highscore)

	retry_button.pressed.connect(_on_retry_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _process(_delta: float) -> void:
	_tap_consumed_this_frame = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_R:
		_on_retry_pressed()
		return

	var tap_pos := Vector2.ZERO
	var is_tap := false
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_tap = true
		tap_pos = event.position
	elif event is InputEventScreenTouch and event.pressed:
		is_tap = true
		tap_pos = event.position

	if not is_tap or _tap_consumed_this_frame:
		return
	_tap_consumed_this_frame = true

	if retry_button.get_global_rect().has_point(tap_pos):
		_on_retry_pressed()
	elif exit_button.get_global_rect().has_point(tap_pos):
		_on_exit_pressed()

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Game.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
