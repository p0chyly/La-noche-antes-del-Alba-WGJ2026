extends Node3D

@export var mouse_sensitivity: float = 0.003
@onready var spring_arm_3d: SpringArm3D = $SpringArm3D
@onready var camera: Camera3D = $SpringArm3D/Camera3D

var h_rotation: float = 0.0
var v_rotation: float = 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_camera(event.relative)

func rotate_camera(mouse_delta: Vector2):
	h_rotation -= mouse_delta.x * mouse_sensitivity
	rotation.y = h_rotation
	
	v_rotation -= mouse_delta.y * mouse_sensitivity
	v_rotation = clamp(v_rotation, deg_to_rad(-60), deg_to_rad(30))
	spring_arm_3d.rotation.x = v_rotation
	
func get_forward_direction() -> Vector3:
	var forward = -camera.global_transform.basis.z
	return forward

func get_right_direction()  -> Vector3:
	var right = camera.global_transform.basis.x
	return right

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
