class_name ObjectRemover
extends Area2D

@export var pipes_container: Node2D

func _on_area_entered(area: Area2D):
  var pipes = area.get_parent() as Pipes

  pipes_container.remove_child(pipes)
  pipes.call_deferred("free")
