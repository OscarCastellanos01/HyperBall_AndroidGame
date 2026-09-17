extends Area2D
class_name Ball

signal scored
signal died(color: Color, world_position: Vector2)

const SIZE := 64.0
const HALF := SIZE * 0.5

@onready var sprite: Sprite2D = $Sprite2D

var vspeed: float = 0.0
var mas_vel: float = 2.0
var menos_vel: float = -2.0
var is_type_a: bool = true
var color_a: Color = Color.WHITE
var color_b: Color = Color.WHITE
var alive: bool = true

var circle_up: Circle
var circle2_up: Circle
var circle_d: Circle
var circle_d2: Circle

func setup(cu: Circle, c2u: Circle, cd: Circle, cd2: Circle, ca: Color, cb: Color) -> void:
	circle_up = cu
	circle2_up = c2u
	circle_d = cd
	circle_d2 = cd2
	color_a = ca
	color_b = cb
	_update_sprite()

func _ready() -> void:
	is_type_a = (randi() % 2 == 0)
	vspeed = [-2.0, 2.0].pick_random()
	_update_sprite()

func _update_sprite() -> void:
	sprite.modulate = color_a if is_type_a else color_b

func current_color() -> Color:
	return color_a if is_type_a else color_b

func _rect(center: Vector2, dy: float = 0.0) -> Rect2:
	return Rect2(center - Vector2(HALF, HALF) + Vector2(0.0, dy), Vector2(SIZE, SIZE))

func _overlaps(other: Circle, dy: float) -> bool:
	return _rect(position, dy).intersects(_rect(other.position))

func _physics_process(_delta: float) -> void:
	if not alive:
		return

	position.y += vspeed

	if is_type_a:
		if _overlaps(circle_d2, 4.0) and vspeed > 0.0:
			_bounce()
		elif _overlaps(circle2_up, -4.0) and vspeed < 0.0:
			_bounce()
	else:
		if _overlaps(circle_d, 4.0) and vspeed > 0.0:
			_bounce()
		elif _overlaps(circle_up, -4.0) and vspeed < 0.0:
			_bounce()

	if menos_vel <= -10.0:
		menos_vel = -10.0
	if mas_vel >= 10.0:
		mas_vel = 10.0

	if not alive:
		return

	if is_type_a:
		if _overlaps(circle_d, 4.0) and vspeed > 0.0:
			_die()
		elif _overlaps(circle_up, -4.0) and vspeed < 0.0:
			_die()
	else:
		if _overlaps(circle_d2, 4.0) and vspeed > 0.0:
			_die()
		elif _overlaps(circle2_up, -4.0) and vspeed < 0.0:
			_die()

func _bounce() -> void:
	if vspeed > 0.0:
		vspeed = menos_vel
		menos_vel -= 1.5
	else:
		vspeed = mas_vel
		mas_vel += 1.5
	is_type_a = (randi() % 2 == 0)
	_update_sprite()
	scored.emit()

func _die() -> void:
	if not alive:
		return
	alive = false
	died.emit(current_color(), position)
	queue_free()

func die_out_of_bounds() -> void:
	_die()
