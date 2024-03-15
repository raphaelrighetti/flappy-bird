class_name Level
extends Node2D

func _ready():
	MyGlobal.object_speed = 0
	MyGlobal.gravity = 0
	MyGlobal.can_spawn_pipes = false
	MyGlobal.game_running = false
	MyGlobal.game_over = false
	MyGlobal.final_score = 0
	MyGlobal.other_theme = false

func _process(_delta):
	if Input.is_action_just_pressed("jump") and not MyGlobal.game_running:
		start_game()

func start_game() -> void:
	MyGlobal.object_speed = MyGlobal.NORMAL_OBJECT_SPEED
	MyGlobal.game_running = true

func _on_game_over_screen_restart_level():
	get_tree().call_deferred("reload_current_scene")
