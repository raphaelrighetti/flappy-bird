class_name Ground
extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D

var texture_width: float = 0

const SPEED: float = 150.0

func _ready():
  texture_width = sprite.texture.get_size().x * scale.x

func _process(delta):
  handle_movement(delta)
  attempt_reposition()

func handle_movement(delta) -> void:
  position.x -= MyGlobal.object_speed * delta

func attempt_reposition() -> void:
  if position.x < - texture_width:
    position.x += texture_width * 2
