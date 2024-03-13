class_name Level
extends Node2D

func _on_player_game_over():
	get_tree().reload_current_scene()
