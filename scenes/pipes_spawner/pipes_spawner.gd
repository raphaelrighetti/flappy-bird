class_name PipesSpawner
extends Node2D

@export var pipes_container: Node2D

@onready var spawn_point: Node2D = $PipesSpawnPoint
@onready var spawn_timer: Timer = $SpawnTimer

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var pipes_scene: PackedScene = preload ("res://scenes/pipes/pipes.tscn")

var can_spawn: bool = true

func _ready():
  if pipes_container == null:
    push_error("\"pipes_container\" must not be null")

func _process(_delta):
  spawn()

func spawn() -> void:
  if can_spawn:
    var pipes = pipes_scene.instantiate() as Pipes
    pipes.position = spawn_point.position
    pipes.position.y = rng.randi_range(pipes.MIN_POSITION_Y, pipes.MAX_POSITION_Y)
    pipes_container.add_child(pipes)
    can_spawn = false
    spawn_timer.start()

func _on_spawn_timer_timeout():
  can_spawn = true
