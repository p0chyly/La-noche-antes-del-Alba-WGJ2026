extends Control

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main2d.tscn")

func _on_creditos_pressed() -> void:
	var creditos = get_node("Créditos")
	if not creditos.visible:
		creditos.visible = true
	else:
		creditos.visible = false

func _on_salir_pressed() -> void:
	get_tree().quit()

func menu_principal() -> void:
	get_tree().change_scene_to_file("res://Scenes/inicio.tscn")
