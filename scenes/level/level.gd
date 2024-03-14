class_name Level
extends Node2D

var game_running: bool = false

func _ready():
	MyGlobal.object_speed = 0
	MyGlobal.can_spawn_pipes = false
	MyGlobal.gravity = 0

func _process(_delta):
	if Input.is_action_just_pressed("jump") and not game_running:
		start_game()

func start_game() -> void:
	MyGlobal.object_speed = MyGlobal.NORMAL_OBJECT_SPEED
	MyGlobal.can_spawn_pipes = true
	MyGlobal.gravity = MyGlobal.NORMAL_GRAVITY
	game_running = true

func _on_game_over_screen_restart_level():
	get_tree().call_deferred("reload_current_scene")
