class_name Pipes
extends Node2D

@export var min_position_y: int = 132
@export var max_position_y: int = 380

const SPEED: float = 150.0

func _physics_process(delta):
  handle_movement(delta)

func handle_movement(delta: float) -> void:
  position.x -= SPEED * delta

func _on_pipe_top_body_entered(body: Player):
  body.emit_game_over()

func _on_pipe_bottom_body_entered(body: Player):
  body.emit_game_over()
