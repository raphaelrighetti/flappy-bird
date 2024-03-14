class_name Pipes
extends Node2D

const MIN_POSITION_Y: int = 132
const MAX_POSITION_Y: int = 380

func _process(delta):
  position.x -= MyGlobal.object_speed * delta

func _on_pipe_top_body_entered(body: Player):
  body.emit_game_over()

func _on_pipe_bottom_body_entered(body: Player):
  body.emit_game_over()

func _on_point_detector_body_entered(body: Player):
  body.emit_add_point()
