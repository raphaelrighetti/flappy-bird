class_name Level
extends Node2D

func _ready():
	Engine.time_scale = 1

func _on_game_over_screen_restart_level():
	get_tree().call_deferred("reload_current_scene")
