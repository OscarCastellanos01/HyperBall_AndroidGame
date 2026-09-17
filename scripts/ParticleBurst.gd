extends Node2D
class_name ParticleBurst

const DOT_TEX := preload("res://assets/sprites/sParticle.png")

@export var color: Color = Color.WHITE
@export var count: int = 12
@export var speed: float = 10.0
@export var life_frames: int = 100
@export var particle_scale: float = 5.0

var _dots: Array[Sprite2D] = []
var _velocities: Array[Vector2] = []
var _frames_left: int = 0

func _ready() -> void:
	_frames_left = life_frames
	var angle_step := TAU / float(count)
	var angle := 0.0
	for i in range(count):
		var dot := Sprite2D.new()
		dot.texture = DOT_TEX
		dot.centered = false
		dot.modulate = color
		dot.scale = Vector2(particle_scale, particle_scale)
		add_child(dot)
		_dots.append(dot)
		_velocities.append(Vector2(cos(angle), sin(angle)) * speed)
		angle += angle_step

func _physics_process(_delta: float) -> void:
	_frames_left -= 1
	for i in range(_dots.size()):
		_dots[i].position += _velocities[i]
	if _frames_left <= 0:
		queue_free()
