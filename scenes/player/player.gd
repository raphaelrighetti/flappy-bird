class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# change this so that it starts playing only when the player start the game
	# (can be done with a signal)
	animated_sprite.play('default')

	position = get_viewport_rect().size / 2

	# checking if it works correctly
	# print("Viewport Rect: ", get_viewport_rect().size / 2)
	# print("Player Position: ", position)

func _physics_process(delta: float):
	# physics
	apply_gravity(delta)
	# handle_movement()
	handle_jump()

	# animation
	handle_rotation()

	move_and_slide()

# physics

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta

func handle_movement() -> void:
	velocity.x = SPEED

func handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

# animation

func handle_rotation() -> void:
	var rot_from_grav: int = int(velocity.y / 10)

	rotation_degrees = rot_from_grav

	if rot_from_grav > 90:
		rotation_degrees = 90