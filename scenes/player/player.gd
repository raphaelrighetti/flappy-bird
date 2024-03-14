class_name Player
extends CharacterBody2D

signal add_point
signal game_over

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -325.0

var can_play: bool = false
var dead: bool = false

func _ready():
	position = get_viewport_rect().size / 2

func _physics_process(delta: float):
	check_game_over()

	apply_gravity(delta)
	handle_jump()

	handle_animation()
	handle_rotation()

	move_and_slide()

func apply_gravity(delta: float) -> void:
	velocity.y += MyGlobal.gravity * delta

func handle_animation() -> void:
	if not dead and not animated_sprite.is_playing():
		animated_sprite.play("default")
	if dead:
		animated_sprite.stop()
		animated_sprite.frame = 1

func handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

func handle_rotation() -> void:
	var rot_from_grav = int(velocity.y / 10)

	if not dead:
		rotation_degrees = rot_from_grav

	if rot_from_grav > 90:
		rotation_degrees = 90

func check_game_over() -> void:
	if is_on_floor():
		emit_game_over()

# public

func emit_add_point() -> void:
	add_point.emit()

func emit_game_over() -> void:
	dead = true

	game_over.emit()
