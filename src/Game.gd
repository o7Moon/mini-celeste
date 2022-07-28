extends Node2D

var loadedLevel: Node

func _ready():
	Global.Game = self
	Global.loadSave()
	var menu: Control = preload("res://src/MainMenu.tscn").instance()
	menu.name = "menu"
	add_child(menu)
	menu.connect("enterLevel",self,"load_main_level",[null])

func load_main_level(ID)->void:
	if has_node("menu"):
		$menu.queue_free()
	if ID == null: ID = Global.levelNumber
	Global.loadedLevel = ID
	if ID > Global.levelNumber: 
		Global.levelNumber = ID
		Global.storeSave()
	if ID == 1:
		Global.startTime = OS.get_ticks_msec()
	var level = load("res://levels/"+String(ID)+".tscn").instance()
	call_deferred("actually_load_level",level)

func actually_load_level(level)->void:
	level.name = "level"
	level.connect("complete",self,"level_complete")
	add_child(level)
	loadedLevel = level

func level_complete()->void:
	loadedLevel.queue_free()
	load_main_level(Global.loadedLevel+1)
