class_name PointsCounter
extends Control

@onready var text_label: RichTextLabel = $RichTextLabel

var number_imgs: Array[String] = []

const NUMBER_RES_PREFIX: String = "res://assets/sprites/"

var points: int = 0

func _ready():
  for n in 10:
    number_imgs.append(NUMBER_RES_PREFIX + str(n) + ".png")

  update_text_label_text()

func _process(_delta):
  if MyGlobal.game_running:
    visible = true
  else:
    visible = false

func update_text_label_text() -> void:
  text_label.text = "[center]" + points_to_img_string() + "[/center]"

func points_to_img_string() -> String:
  var imgs_string: String = ""

  for c in str(points):
    imgs_string = imgs_string + "[img]" + NUMBER_RES_PREFIX + c + ".png" + "[/img]"

  return imgs_string

func _on_player_add_point():
  points += 1
  update_text_label_text()
