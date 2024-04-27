extends Label

var elapsed

func _ready():
	if Globalvar.speedrunsettings == true:
		visible = true
	elapsed = Save.data.time

func _process(delta):
	elapsed += delta
	
	var milliseconds = int(elapsed*1000)%1000
	var seconds = int(elapsed)%60
	var minutes = int(elapsed/60)%60
	var hours = int(elapsed/60/60)
	var str_elapsed = "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, milliseconds]
	
	text = str_elapsed
	
	if $".."/".."/Endscreen/Control.visible:
		visible = false
