extends Node2D
class_name Circle

@export var min_x: float = 0.0
@export var max_x: float = 0.0
@export var first_tap_speed: float = 0.0
@export var second_tap_speed: float = 0.0

var hspeed: float = 0.0
var _toggled: bool = false

func on_tap() -> void:
	if not _toggled:
		_toggled = true
		hspeed = first_tap_speed
	else:
		_toggled = false
		hspeed = second_tap_speed

func _physics_process(_delta: float) -> void:
	if hspeed == 0.0:
		return
	var next_x := position.x + hspeed
	if hspeed < 0.0 and next_x <= min_x:
		position.x = min_x
		hspeed = 0.0
	elif hspeed > 0.0 and next_x >= max_x:
		position.x = max_x
		hspeed = 0.0
	else:
		position.x = next_x
