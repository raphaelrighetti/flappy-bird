class_name Pipes
extends Node2D

@onready var get_point_audio: AudioStreamPlayer = $GetPointAudio
@onready var pipe_top_sprite: Sprite2D = $PipeTop/Sprite2D
@onready var pipe_bottom_sprite: Sprite2D = $PipeBottom/Sprite2D

var current_texture_path: String = "res://assets/sprites/pipe-green.png"

const MIN_POSITION_Y: int = 104
const MAX_POSITION_Y: int = 348

func _process(delta):
  handle_movement(delta)
  change_theme()

func handle_movement(delta: float) -> void:
  position.x -= MyGlobal.object_speed * delta

func change_theme() -> void:
  if not MyGlobal.other_theme:
    current_texture_path = "res://assets/sprites/pipe-green.png"
  else:
    current_texture_path = "res://assets/sprites/pipe-red.png"

  if current_texture_path != pipe_top_sprite.texture.resource_path:
    pipe_top_sprite.texture = ResourceLoader.load(current_texture_path)

  if current_texture_path != pipe_bottom_sprite.texture.resource_path:
    pipe_bottom_sprite.texture = ResourceLoader.load(current_texture_path)

func _on_pipe_top_body_entered(body: Player):
  body.emit_game_over()

func _on_pipe_bottom_body_entered(body: Player):
  body.emit_game_over()

func _on_point_detector_body_entered(body: Player):
  get_point_audio.play()
  body.emit_add_point()
