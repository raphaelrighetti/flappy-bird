class_name InitialScreen
extends Control

func _process(_delta):
  if MyGlobal.game_running:
    visible = false
  else:
    visible = true
