extends Node

var dialog_index : int = 0
var flags : Dictionary = {}
var dialog_lines : Array = []

var player_position_3d : Vector3 = Vector3.ZERO
var player_rotation_3d : Vector3 = Vector3.ZERO
var position_saved : bool = false

var completedAnchorEvents : Array = []

func _ready() -> void:
	dialog_lines = load_dialog("res://Historia/Dialogos.json")

func load_dialog(file_path):
	if not FileAccess.file_exists(file_path):
		return []
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		return []
	var content = file.get_as_text()
	return JSON.parse_string(content)

func get_anchor_position(anchor: String) -> int:
	for i in range(dialog_lines.size()):
		if dialog_lines[i].has("anchor") and dialog_lines[i]["anchor"] == anchor:
			return i
			
	printerr("No se encontró el anchor: " + anchor)
	return 0
