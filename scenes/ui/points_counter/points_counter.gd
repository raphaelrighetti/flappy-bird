class_name PointsCounter
extends Control

@onready var points_counter_text: PointsCounterText = $PointsCounterText

func _process(_delta):
  if MyGlobal.game_over:
    visible = false
  elif MyGlobal.game_running:
    visible = true
  else:
    visible = false

func _on_player_add_point():
  points_counter_text.add_point()
  MyGlobal.final_score = points_counter_text.points
