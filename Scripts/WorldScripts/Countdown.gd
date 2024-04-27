extends Label

var timeleft
var milliseconds
var seconds
var minutes

func _ready():
	if Save.data.godgamer == true:
		visible = true
	var scene = (get_tree().get_current_scene().get_name())
	if (scene == "Asylum" or scene == "EvilAsylum") and Save.data.timerAsylum > 0:
		$CountdownTimer.wait_time = Save.data.timerAsylum
	if scene == "WeebZone" and Save.data.timerWeebZone > 0:
		$CountdownTimer.wait_time = Save.data.timerWeebZone
	if scene == "MadmonqRealm" and Save.data.timerMadmonqRealm > 0:
		$CountdownTimer.wait_time = Save.data.timerMadmonqRealm
	$CountdownTimer.start()
		
func _process(_delta):
	if Save.data.godgamer == true:
		timeleft = $CountdownTimer.time_left
		milliseconds = int(timeleft*1000)%1000
		seconds = int(timeleft)%60
		minutes = int(timeleft/60)%60
		var str_elapsed = "%02d:%02d.%03d" % [minutes, seconds, milliseconds]
		text = str(str_elapsed)
	if $".."/".."/Endscreen/Control.visible:
		visible = false
		
func _exit_tree():
	var scene = (get_tree().get_current_scene().get_name())
	if Globalvar.godgamerdeath == false:
		if scene == "Asylum" or scene == "EvilAsylum":
			Save.data.timerAsylum = $CountdownTimer.time_left
		if scene == "WeebZone":
			Save.data.timerWeebZone = $CountdownTimer.time_left
		if scene == "MadmonqRealm":
			Save.data.timerMadmonqRealm = $CountdownTimer.time_left
		Save.save_data()
		
func _on_CountdownTimer_timeout():
	if Save.data.godgamer == true and $".."/".."/Endscreen/Control.visible == false:
		Globalvar.godgamerdeath = true
		$".."/".."/Player.state = $".."/".."/Player.DEATH
