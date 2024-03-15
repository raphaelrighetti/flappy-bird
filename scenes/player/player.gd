class_name Player
extends CharacterBody2D

signal add_point
signal game_over

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wing_audio: AudioStreamPlayer = $WingAudio
@onready var death_audio: AudioStreamPlayer = $DeathAudio
@onready var hit_audio: AudioStreamPlayer = $HitAudio

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -325.0
const MIN_WING_PITCH: float = 1.05
const MAX_WING_PITCH: float = 1.25

var in_position: bool = false
var can_play: bool = false
var can_play_death_audio: bool = true
var dead: bool = false

func _ready():
	position = get_viewport_rect().size / 2

func _physics_process(delta: float):
	check_game_over()

	apply_gravity(delta)
	handle_jump()

	attempt_reposition()
	handle_animation()
	handle_rotation()

	move_and_slide()

func apply_gravity(delta: float) -> void:
	velocity.y += MyGlobal.gravity * delta

func attempt_reposition() -> void:
	if MyGlobal.game_running and not in_position:
		animation_player.current_animation = "move_back_position_x"

func handle_animation() -> void:
	if not dead and not animated_sprite.is_playing():
		animated_sprite.play("default")
	if dead:
		animated_sprite.stop()
		animated_sprite.frame = 1

func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and in_position:
		wing_audio.pitch_scale = rng.randf_range(MIN_WING_PITCH, MAX_WING_PITCH)
		wing_audio.play()
		velocity.y = JUMP_VELOCITY

func handle_rotation() -> void:
	var rot_from_grav = int(velocity.y / 10)

	if in_position:
		if not dead:
			rotation_degrees = rot_from_grav

		if rot_from_grav > 90:
			rotation_degrees = 90

func check_game_over() -> void:
	if is_on_floor() and not dead:
		can_play_death_audio = false
		emit_game_over()

func play_hit_sound() -> void:
	hit_audio.play()

# public

func emit_add_point() -> void:
	add_point.emit()

func emit_game_over() -> void:
	if not dead:
		hit_audio.play()

	if not dead and can_play_death_audio:
		death_audio.play()

	dead = true
	game_over.emit()

# signal subscriptions

func _on_animation_player_animation_finished(anim_name: StringName):
	match anim_name:
		"move_back_position_x":
			MyGlobal.gravity = MyGlobal.NORMAL_GRAVITY
			MyGlobal.can_spawn_pipes = true
			in_position = true
