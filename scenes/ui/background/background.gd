class_name Background
extends TextureRect

var current_texture_path = "res://assets/sprites/background-day.png"

func _process(_delta):
  if not MyGlobal.other_theme:
    current_texture_path = "res://assets/sprites/background-day.png"
  else:
    current_texture_path = "res://assets/sprites/background-night.png"

  if current_texture_path != texture.resource_path:
    texture = ResourceLoader.load(current_texture_path)
