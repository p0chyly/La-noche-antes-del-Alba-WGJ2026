extends Node2D

@onready var character = %Character
@onready var dialog_ui = %DialogUI
@onready var fondo: TextureRect = $CanvasLayer/Fondo

var dialog_index : int = 0
var dialog_lines : Array = []
var flags : Dictionary = {}
	
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	dialog_lines = GameManager.dialog_lines
	dialog_ui.choice_selected.connect(_on_choice_selected)
	dialog_index = GameManager.dialog_index
	flags = GameManager.flags
	process_current_line()
	
func _input(event: InputEvent) -> void:
	var line = dialog_lines[dialog_index]
	var has_choices = line.has("choices")
	if event.is_action_pressed("next_line") and not has_choices:
		if dialog_index < len(dialog_lines) - 1:
			dialog_index += 1
			process_current_line()
	#if event.is_action_pressed("pausar") and not get_tree().paused:
		#get_tree().paused = true
	#else: if event.is_action_pressed("pausar") and get_tree().paused:
		#get_tree().paused = false

func load_dialog(file_path):
	if not FileAccess.file_exists(file_path):
		printerr("El archivo no existe: ", file_path)
		return null
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		printerr("Error al abrir el archivo: ", file_path)
		return null
	
	var content = file.get_as_text()
	
	var json_content = JSON.parse_string(content)
	if json_content == null:
		printerr("Error de -parseo- del archivo JSON: ", file_path)
		return null
		
	return json_content

func process_current_line():
	var line = dialog_lines[dialog_index]
	
	if line.has("conditions"):
		var target_goto = check_conditions(line)
		var new_index = get_anchor_position(target_goto)
		if new_index != null:
			dialog_index = new_index
			process_current_line()
		return
		
	if line.has("goto"):
		var new_index = get_anchor_position(line["goto"])
		if new_index != null:
			dialog_index = new_index
			process_current_line()
		return
		
	if line.has("anchor"):
		dialog_index += 1
		process_current_line()
		return
				
	if line.has("choices"):
		dialog_ui.display_choices(line["choices"])
		return
	
	if line.has("escena3D"):
		#get_tree().paused = true
		GameManager.dialog_index = dialog_index + 1
		GameManager.flags = flags
		cambiar_escena_a_("res://Scenes/main3d.tscn")
		return
		
	if line.has("end"):
		#get_tree().paused = true
		cambiar_escena_a_("res://Scenes/pantallaFinal.tscn")
		return
		
	if line.has("background"):
		var texture_path = line["background"]
		if FileAccess.file_exists(texture_path):
			fondo.texture = load(texture_path)
		else:
			printerr("No se encontró la imagen de fondo", texture_path)
		dialog_index += 1
		process_current_line()
		return
		
	var character_name = Character.get_enum_from_string(line["speaker"])
	dialog_ui.change_line(character_name, line["text"])
		
func cambiar_escena_a_(scene) -> void:
	get_tree().change_scene_to_file.call_deferred(scene)
		
func check_conditions(line: Dictionary) -> String:
	if line.has("conditions"):
		for condition in line["conditions"]:
			var reqs: Dictionary = condition["if"]
			var match_all = true
			
			for key in reqs.keys():
				if flags.get(key, false) != reqs[key]:
					match_all = false
					break
			
			if match_all:
				return condition["goto"]
	return line.get("default", "")
	
func get_anchor_position(anchor: String):
	return GameManager.get_anchor_position(anchor)

func _on_choice_selected(choice_data):
	var target_anchor = ""
	if choice_data is Dictionary:
		if choice_data.has("set_flags"):
			for key in choice_data["set_flags"]:
				flags[key] = choice_data["set_flags"][key]
				print("Flag actualizada: ", key, " = ", flags[key])
		target_anchor = choice_data.get("goto", "")
	else:
		target_anchor = choice_data
		
	print("Estado actual de -flags-: ", flags)
	
	var new_index = get_anchor_position(target_anchor)
	if new_index != null:
		dialog_index = new_index
		process_current_line()
		#sonido
	else:
		printerr("El jugador eligió una opción cuyo -goto- no existe", target_anchor)
	
	
	
	
	
	
	
	
	
	
