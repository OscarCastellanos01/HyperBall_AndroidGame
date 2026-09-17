extends Node

const SAVE_PATH := "user://puntuacion.cfg"

var points: int = 0
var highscore: int = 0
var ads: int = 0

func _ready() -> void:
	load_data()

func load_data() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		highscore = cfg.get_value("puntos", "highscore", 0)
		ads = cfg.get_value("puntos", "anuncios", 0)
	else:
		highscore = 0
		ads = 0

func save_data() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("puntos", "highscore", highscore)
	cfg.set_value("puntos", "anuncios", ads)
	cfg.save(SAVE_PATH)

func register_score(final_points: int) -> bool:
	points = final_points
	var new_highscore := false
	if points > highscore:
		new_highscore = true
		highscore = points
		save_data()
	return new_highscore
