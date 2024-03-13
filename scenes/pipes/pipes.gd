class_name Pipes
extends Node2D

const MIN_POSITION_Y: int = 132
const MAX_POSITION_Y: int = 380
const SPEED: float = 150.0

func _process(delta):
  position.x -= SPEED * delta

func _on_pipe_top_body_entered(body: Player):
  body.emit_game_over()

func _on_pipe_bottom_body_entered(body: Player):
  body.emit_game_over()
