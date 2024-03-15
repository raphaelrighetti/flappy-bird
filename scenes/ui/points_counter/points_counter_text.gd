class_name PointsCounterText
extends RichTextLabel

var number_imgs: Array[String] = []

const NUMBER_RES_PREFIX: String = "res://assets/sprites/"

var points: int = 0

func _ready():
  for n in 10:
    number_imgs.append(NUMBER_RES_PREFIX + str(n) + ".png")

  update_text_label_text()

func update_text_label_text() -> void:
  text = "[center]" + points_to_img_string() + "[/center]"

func points_to_img_string() -> String:
  var imgs_string: String = ""

  for c in str(points):
    imgs_string = imgs_string + "[img]" + NUMBER_RES_PREFIX + c + ".png" + "[/img]"

  return imgs_string

func add_point() -> void:
  points += 1
  update_text_label_text()

func set_points(value: int) -> void:
  points = value
  update_text_label_text()
