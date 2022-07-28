extends Area2D

signal collected

var plyr: Player = null

func _on_strawberry_body_entered(body):
	if body is Player:
		plyr = body
		plyr.deadTimer = 30

func _physics_process(delta):
	if plyr != null:
		if plyr.deadTimer == 10: emit_signal("collected")
