class_name PipesSpawner
extends Node2D

@export var pipes_container: Node2D

@onready var spawn_point: Node2D = $PipesSpawnPoint
@onready var spawn_timer: Timer = $SpawnTimer

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var pipes_scene: PackedScene = preload ("res://scenes/pipes/pipes.tscn")

var points_counter: int = 0

const CHANGE_DIFFICULTY_BASE: int = 5
const MIN_WAIT_TIME: int = 1
const WAIT_TIME_SUM: float = 0.1
const MAX_OBJECT_SPEED: int = 200
const OBJECT_SPEED_SUM: float = 2.5

func _ready():
  if pipes_container == null:
    push_error("\"pipes_container\" must not be null")

func _process(_delta):
  attempt_spawn()
  attempt_change_difficulty()

func attempt_spawn() -> void:
  if MyGlobal.can_spawn_pipes:
    var pipes = pipes_scene.instantiate() as Pipes
    pipes.position = spawn_point.position
    pipes.position.y = rng.randi_range(pipes.MIN_POSITION_Y, pipes.MAX_POSITION_Y)
    pipes_container.add_child(pipes)
    MyGlobal.can_spawn_pipes = false
    spawn_timer.start()

func attempt_change_difficulty() -> void:
  if MyGlobal.final_score == points_counter + CHANGE_DIFFICULTY_BASE:
    if spawn_timer.wait_time > MIN_WAIT_TIME:
      spawn_timer.wait_time -= WAIT_TIME_SUM
    if MyGlobal.object_speed < MAX_OBJECT_SPEED:
      MyGlobal.object_speed += OBJECT_SPEED_SUM
    MyGlobal.other_theme = not MyGlobal.other_theme
    points_counter = MyGlobal.final_score

func _on_spawn_timer_timeout():
  MyGlobal.can_spawn_pipes = true
