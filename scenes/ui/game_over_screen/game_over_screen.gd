class_name GameOverScreen
extends Control

signal restart_level

var can_restart: bool = false

func _process(_delta):
	check_restart_level()

func check_restart_level() -> void:
	if can_restart and Input.is_action_just_pressed("jump"):
		restart_level.emit()

func _on_player_game_over():
	visible = true
	Engine.time_scale = 0
	can_restart = true
