extends CanvasLayer

var oneshot = false
var timerready = false
var skip = false
var scene

func _ready():
	scene = (get_tree().get_current_scene().get_name())

func _process(_delta):
	if $Control.visible == true and oneshot == false:
		endscreen()
		if Globalvar.speedrunsettings == true:
			skip = true
		oneshot = true
		$Timer.start()
	if (oneshot == true and Input.is_action_just_pressed("ui_accept") and timerready == true) or skip == true:
		if scene == "Asylum":
			Save.data.clearedAsylum = 1
			$".."/Music/Background1.play(0)
			Save.save_data()
			var _error = get_tree().change_scene("res://Scenes/Asylum/AsylumBoss.tscn")
		if scene == "EvilAsylum":
			Save.data.clearedEvil = 1
			Save.save_data()
			var _error = get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")
		if scene == "AsylumBoss":
			Save.data.clearedAsylumBoss = 1
			$".."/Music/Background1.play(0)
			Save.save_data()
			var _error = get_tree().change_scene("res://Scenes/WeebZone/WeebZone.tscn")
		if scene == "WeebZone":
			Save.data.clearedWeebZone = 1
			$".."/Music/Background1.play(0)
			Save.save_data()
			var _error = get_tree().change_scene("res://Scenes/WeebZone/WeebZoneBoss.tscn")
		if scene == "WeebZoneBoss":
			Save.data.clearedWeebZoneBoss = 1
			$".."/Music/Background1.play(0)
			Save.save_data()
			var _error = get_tree().change_scene("res://Scenes/MadmonqRealm/MadmonqRealm.tscn")
		if scene == "MadmonqRealm":
			Save.data.clearedMadmonqRealm = 1
			$".."/Music/Background1.play(0)
			Save.save_data()
			var _error = get_tree().change_scene("res://Scenes/MadmonqRealm/MadmonqRealmBoss.tscn")
		if scene == "MadmonqRealmBoss":
			Save.data.clearedMadmonqRealmBoss = 1
			$".."/Music/Background1.play(0)
			Save.save_data()
			var _error = get_tree().change_scene("res://Scenes/Menus/Ending.tscn")
		
func endscreen():
	var savetime = 0
	if scene == "Asylum" or scene == "EvilAsylum":
		Save.data.AsylumTime += Globalvar.time
		savetime = Save.data.AsylumTime
	if scene == "WeebZone":
		Save.data.WeebZoneTime += Globalvar.time
		savetime = Save.data.WeebZoneTime
	if scene == "MadmonqRealm":
		Save.data.MadmonqRealmTime += Globalvar.time
		savetime = Save.data.MadmonqRealmTime
	if scene == "AsylumBoss":
		Save.data.AsylumBossTime += Globalvar.time
		savetime = Save.data.AsylumBossTime
	if scene == "WeebZoneBoss":
		Save.data.WeebZoneBossTime += Globalvar.time
		savetime = Save.data.AsylumBossTime
	if scene == "MadmonqRealmBoss":
		Save.data.MadmonqRealmBossTime += Globalvar.time
		savetime = Save.data.MadmonqRealmBossTime
	
	Save.data.time += Globalvar.time
	Globalvar.time = 0
	
	var elapsed = savetime
	var milliseconds = int(elapsed*1000)%1000
	var seconds = int(elapsed)%60
	var minutes = int(elapsed/60)%60
	var hours = int(elapsed/60/60)
	var str_elapsed = "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, milliseconds]
	$Control/GridContainer/TimeStat.text = str_elapsed
	
	var deaths = 0
	if scene == "AsylumBoss":
		deaths = Save.data.AsylumBossDeaths
	elif scene == "WeebZoneBoss":
		deaths = Save.data.WeebZoneBossDeaths
	elif scene == "MadmonqRealmBoss":
		deaths = Save.data.MadmonqRealmBossDeaths
	else:
		$Control/GridContainer/DeathsStat.visible = false
		$Control/GridContainer/DeathsLabel.visible = false
	$Control/GridContainer/DeathsStat.text = str(deaths)
	
	var horses = 0
	if scene == "Asylum" or scene == "EvilAsylum":
		horses = Save.data.horse[0] + Save.data.horse[1] + Save.data.horse[2]
	elif scene == "WeebZone":
		horses = Save.data.horse[3] + Save.data.horse[4] + Save.data.horse[5]
	elif scene == "MadmonqRealm":
		horses = Save.data.horse[6] + Save.data.horse[7] + Save.data.horse[8]
	else:
		$Control/GridContainer/HorsesStat.visible = false
		$Control/GridContainer/HorsesLabel.visible = false
	$Control/GridContainer/HorsesStat.text = str(horses)
	
	if Save.data.godgamer == true:
		$Control/HBoxContainer/LevelText.modulate = Color(255,0,0,1)
		$Control/HBoxContainer/LevelLabel.modulate = Color(255,0,0,1)

func _on_Timer_timeout():
	timerready = true
