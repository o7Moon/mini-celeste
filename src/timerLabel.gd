extends Label

func _ready()->void:
	if Global.startTime != -1:
		var timePassed: int = OS.get_ticks_msec()-Global.startTime
		var formatted: String = String(timePassed/60000)+":"+String((timePassed/1000)%60)+"."+String(timePassed%1000)
		text = formatted
