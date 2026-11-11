extends Control

const ChoiceButtonScene = preload("res://Scenes/opcion_1.tscn")
signal choice_selected

@onready var dialog_line = %DialogLine
@onready var speaker_name = %SpeakerName
@onready var choice_list = %Opciones

func _ready():
	choice_list.hide()

func display_choices(choices: Array):
	for child in choice_list.get_children():
		child.queue_free()
		
	for choice in choices:
		var choice_button = ChoiceButtonScene.instantiate()
		choice_button.text = choice["text"]
		
		choice_button.pressed.connect(_on_choice_button_pressed.bind(choice))
		choice_list.add_child(choice_button)
		
	choice_list.show()

func _on_choice_button_pressed(choice_data: Dictionary):
	choice_selected.emit(choice_data)
	choice_list.hide()
	
func change_line(character_name: Character.Name, line: String):
	speaker_name.text = Character.CHARACTER_DETAILS[character_name]["name"]
	dialog_line.text = line










































			
