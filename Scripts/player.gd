extends CharacterBody3D

@export var camera_controller: Node3D
@export var skin: Node3D
@export var blend_speed = 15.0

@onready var rotation_speed: float = 10.0
@onready var animation_tree = $AlbaAnimations/AnimationTree

var run_val = 0.0
var walk_val = 0.0

enum {IDLE, WALK, RUN, JUMP}
var currentAnimation = IDLE

const SPEED = 10.0
const JUMP_VELOCITY = 8.0

#var mouse_sensitivity := 0.1
#var rotation_x := 0.0
#var rotation_y := 0.0

#@export var camera : Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print("EN JUGADOR - Al iniciar _ready. ¿position_saved es true?: ", GameManager.position_saved)
	print("EN JUGADOR - Posición que hay en GameManager: ", GameManager.player_position_3d)
	if GameManager.position_saved:
		global_position = GameManager.player_position_3d
		print("POSICIÓN APLICADA AL JUGADOR: ", global_position)
		global_rotation = GameManager.player_rotation_3d
		velocity = Vector3.ZERO
		global_position.y += 0.2
		GameManager.position_saved = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		currentAnimation = WALK
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_direction = get_move_direction(input_dir)
	
	if move_direction:
		velocity.x = move_direction.x * SPEED
		velocity.z = move_direction.z * SPEED
		rotate_character(move_direction, delta)
		currentAnimation = WALK
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		currentAnimation = IDLE

	move_and_slide()
	handle_animations(delta)
	update_tree()

func get_move_direction(input_dir: Vector2) -> Vector3:
	var forward = camera_controller.get_forward_direction()
	var right = camera_controller.get_right_direction()
	return(forward * -input_dir.y + right * input_dir.x).normalized()

func _unhandled_input(event: InputEvent) -> void:
	pass
	#if event is InputEventMouseMotion:
		#rotation_y -= event.relative.x * mouse_sensitivity
		#rotation_x -= event.relative.y * mouse_sensitivity
		#
		#rotation_x = clamp(rotation_x, -90, 90)

func rotate_character(move_direction: Vector3, delta: float):
	var target_rotation = atan2(move_direction.x, move_direction.z)
	var new_rotation = lerp_angle(skin.rotation.y, target_rotation, rotation_speed * delta)
	skin.rotation.y = new_rotation
		
func update_tree():
	#animation_tree.set("parameters/Run/blend_amount", run_val)
	animation_tree.set("parameters/WalkAnim/blend_amount", walk_val)
		
func handle_animations(delta):
	match currentAnimation:
		IDLE:
			run_val = lerpf(run_val,0.0,blend_speed*delta)
			walk_val = lerpf(run_val,0.0,blend_speed*delta)
		RUN:
			run_val = lerpf(run_val,1.0,blend_speed*delta)
			walk_val = lerpf(run_val,0.0,blend_speed*delta)
		WALK:
			run_val = lerpf(run_val,0.0,blend_speed*delta)
			walk_val = lerpf(run_val,1.0,blend_speed*delta)
