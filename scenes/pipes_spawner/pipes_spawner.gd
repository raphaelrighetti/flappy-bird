class_name PipesSpawner
extends Node2D

@export var pipes_container: Node2D

@onready var spawn_point: Node2D = $PipesSpawnPoint
@onready var pipes_remover: Area2D = $PipesRemover
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
    pipes.position.y = rng.randi_range(pipes.min_position_y, pipes.max_position_y)
    pipes_container.add_child(pipes)
    can_spawn = false
    spawn_timer.start()

func _on_spawn_timer_timeout():
  can_spawn = true

func _on_pipes_remover_area_entered(area: Area2D):
  var pipes = area.get_parent() as Pipes

  pipes_container.remove_child(pipes)
  pipes.call_deferred("free")
