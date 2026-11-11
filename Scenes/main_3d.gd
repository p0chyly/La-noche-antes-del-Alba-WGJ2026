extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var pecari: CollisionShape3D = $Pecari/CollisionShape3D
@onready var ciervo: CollisionShape3D = $Ciervo/CollisionShape3D
@onready var zorro: CollisionShape3D = $Zorro/CollisionShape3D
@onready var lechuza: CollisionShape3D = $Lechuza/CollisionShape3D

func _ready() -> void:
	if GameManager.position_saved:
		global_position = GameManager.player_position_3d
		global_rotation = GameManager.player_rotation_3d
	
	if "EventoPecari" in GameManager.completedAnchorEvents:
		if has_node("Pecari"):
			$Pecari.queue_free()
	if "EventoCiervo" in GameManager.completedAnchorEvents:
		if has_node("Ciervo"):
			$Ciervo.queue_free()
	if "EventoZorro" in GameManager.completedAnchorEvents:
		if has_node("Zorro"):
			$Zorro.queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("salir"):
		get_tree().quit()
	
func _on_pecari_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		GameManager.player_position_3d = body.global_position
		GameManager.player_rotation_3d = body.global_rotation
		GameManager.position_saved = true
		GameManager.dialog_index = GameManager.get_anchor_position("EventoPecari")
		if not "EventoPecari" in GameManager.completedAnchorEvents:
			GameManager.completedAnchorEvents.append("EventoPecari")
		if has_node("Pecari"):
			$Pecari.queue_free()
		get_tree().change_scene_to_file.call_deferred("res://Scenes/main2d.tscn")
		
func _on_ciervo_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		GameManager.player_position_3d = body.global_position
		GameManager.player_rotation_3d = body.global_rotation
		GameManager.position_saved = true
		GameManager.dialog_index = GameManager.get_anchor_position("EventoCiervo")
		if not "EventoCiervo" in GameManager.completedAnchorEvents:
			GameManager.completedAnchorEvents.append("EventoCiervo")
		if has_node("Ciervo"):
			$Ciervo.queue_free()
		get_tree().change_scene_to_file.call_deferred("res://Scenes/main2d.tscn")

func _on_zorro_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		GameManager.player_position_3d = body.global_position
		GameManager.player_rotation_3d = body.global_rotation
		GameManager.position_saved = true
		GameManager.dialog_index = GameManager.get_anchor_position("EventoZorro")
		if not "EventoZorro" in GameManager.completedAnchorEvents:
			GameManager.completedAnchorEvents.append("EventoZorro")
		if has_node("Zorro"):
			$Zorro.queue_free()
		get_tree().change_scene_to_file.call_deferred("res://Scenes/main2d.tscn")

func _on_lechuza_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		GameManager.dialog_index = GameManager.get_anchor_position("EventoLechuza")
		if not "EventoLechuza" in GameManager.completedAnchorEvents:
			GameManager.completedAnchorEvents.append("EventoLechuza")
		if has_node("Lechuza"):
			$Lechuza.queue_free()
		get_tree().change_scene_to_file.call_deferred("res://Scenes/main2d.tscn")
