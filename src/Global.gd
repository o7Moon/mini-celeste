extends Node

enum MODE {
	MENU,
	MAINLEVELS
}

var Mode: int = MODE.MENU
var Game: Node

var levelNumber: int
var loadedLevel
var startTime: float = -1

func loadSave()->void:
	var file: File = File.new()
	if file.file_exists("user://save"):
		file.open("user://save",File.READ)
		levelNumber = file.get_8()
	else:
		file.open("user://save",File.WRITE)
		file.seek(0)
		file.store_8(1)
		levelNumber = 1

func storeSave()->void:
	var file: File = File.new()
	file.open("user://save",File.WRITE)
	file.seek(0)
	file.store_8(levelNumber)

func _ready()->void:
	loadSave()
