extends Control

signal enterLevel

func _ready():
	for button in $Buttons.get_children():
		button.connect("mouse_entered",self,"onButtonFocus", [button])
		button.connect("mouse_exited",self,"onButtonDefocus", [button])
	if Global.levelNumber > 1:
		$Buttons/Continue.visible = true

func onButtonFocus(button: Button)->void:
	button.margin_left = 5

func onButtonDefocus(button: Button)->void:
	button.margin_left = 0

func newGamePressed()->void:
	Global.levelNumber = 1
	emit_signal("enterLevel")

func continuePressed()->void:
	emit_signal("enterLevel")
