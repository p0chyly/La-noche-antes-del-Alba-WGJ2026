class_name Character
extends Node2D

enum Name{
	NARRADORA,
	ALBA,
	TITO,
	PADRE,
	MADRE,
	BUITRE1,
	BUITRE2,
	LIEBRE,
	VOZ,
	PECARI,
	CIERVO,
	LECHUZA,
	ZORRO,
	CONDUCTORA
}

const CHARACTER_DETAILS: Dictionary = {
	Name.ALBA: {
		"name": "Alba"
	},
	Name.TITO: {
		"name": "Tito"
	},
	Name.PADRE: {
		"name": "Padre"
	},
	Name.MADRE: {
		"name": "Madre"
	},
	Name.NARRADORA: {
		"name": "Narradora"
	},
	Name.BUITRE1: {
		"name": "Buitre1"
	},
	Name.BUITRE2: {
		"name": "Buitre2"
	},
	Name.LIEBRE: {
		"name": "Liebre"
	},
	Name.VOZ: {
		"name": "Voz"
	},
	Name.PECARI: {
		"name": "Pecari"
	},
	Name.CIERVO: {
		"name": "Ciervo"
	},
	Name.LECHUZA: {
		"name": "Lechuza"
	},
	Name.ZORRO: {
		"name": "Zorro"
	},
	Name.CONDUCTORA: {
		"name": "Conductora"
	},
}

static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()
	if Name.has(upper_string):
		return Name[upper_string]
	else:
		push_error("Nombre de personaje inválido: " + string_value)
		return -1
