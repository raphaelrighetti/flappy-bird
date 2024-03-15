class_name GameOverScreen
extends Control

signal restart_level

@onready var score_text: PointsCounterText = $FinalScoreBackground/ScoreText
@onready var best_score_text: PointsCounterText = $FinalScoreBackground/BestScoreText

var best_score_config = ConfigFile.new()

var can_restart: bool = false

func _ready():
	best_score_config.load("res://best-score.cfg")

func _process(_delta):
	check_restart_level()

func check_restart_level() -> void:
	if can_restart and Input.is_action_just_pressed("jump"):
		restart_level.emit()

func set_best_score() -> void:
	var player_best_score: int = best_score_config.get_value("player", "best_score")

	if player_best_score != null:
		if MyGlobal.final_score > player_best_score:
			best_score_config.set_value("player", "best_score", MyGlobal.final_score)
			best_score_config.save("res://best-score.cfg")

func _on_player_game_over():
	set_best_score()

	visible = true
	score_text.set_points(MyGlobal.final_score)
	best_score_text.set_points(best_score_config.get_value("player", "best_score"))
	MyGlobal.object_speed = 0
	MyGlobal.game_over = true
	can_restart = true
