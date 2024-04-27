extends Control

var milliseconds = 0
var seconds = 0
var minutes = 0
var hours = 0
var str_elapsed = "%02d:%02d:%02d.%03d"

var exit = false

func _ready():
	endscreen()
	$Control.visible = true
	$AudioStreamPlayer.play()
	$Control/Credits/CreditsAnimationPlayer.play("ForsencoreFade")

func _process(delta):
	
	if exit == true:
		$Control/ExitLabel.modulate.a += delta
		if $Control/ExitLabel.modulate.a > 1.0:
			$Control/ExitLabel.modulate.a = 1.0
	
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel")) and $Control.visible == false:
		if $VideoPlayer1.paused:
			$VideoPlayer1.paused = false
			$PauseControl.visible = false
		else:
			$VideoPlayer1.paused = true
			$PauseControl.visible = true
	if Input.is_action_just_pressed("ui_accept") and exit:
		var _error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")

func endscreen():
	calcTime(Save.data.time)
	$Control/GridContainer/TimeStat.text = str_elapsed
	calcTime(Save.data.AsylumTime)
	$Control/GridContainer/AsylumTimeStat.text = str_elapsed
	calcTime(Save.data.WeebZoneTime)
	$Control/GridContainer/WeebTimeStat.text = str_elapsed
	calcTime(Save.data.MadmonqRealmTime)
	$Control/GridContainer/MadmonqTimeStat.text = str_elapsed
	calcTime(Save.data.AsylumBossTime)
	$Control/GridContainer/AsylumBossTimeStat.text = str_elapsed
	calcTime(Save.data.WeebZoneBossTime)
	$Control/GridContainer/WeebBossTimeStat.text = str_elapsed
	calcTime(Save.data.MadmonqRealmBossTime)
	$Control/GridContainer/MadmonqBossTimeStat.text = str_elapsed
	
	var deaths = Save.data.deaths
	$Control/GridContainer/DeathsStat.text = str(deaths)
	deaths = Save.data.AsylumBossDeaths
	$Control/GridContainer/NinaDeathsStat.text = str(deaths)
	deaths = Save.data.WeebZoneBossDeaths
	$Control/GridContainer/xQcDeathsStat.text = str(deaths)
	deaths = Save.data.MadmonqRealmBossDeaths
	$Control/GridContainer/ForsenDeathsStat.text = str(deaths)
	
	var horses = Save.data.horses
	$Control/GridContainer/HorsesStat.text = str(horses)
	
	if Save.data.recordSecret > 0:
		$Control/GridContainer/SecretLabel.visible = true
		$Control/GridContainer/SecretStat.visible = true
		calcTime(Save.data.recordSecret)
		$Control/GridContainer/SecretStat.text = str_elapsed
	
	Save.data.completion = (Save.data.clearedAsylum + Save.data.clearedAsylumBoss + Save.data.clearedWeebZone + Save.data.clearedWeebZoneBoss + Save.data.clearedMadmonqRealm + Save.data.clearedMadmonqRealmBoss)*12 + Save.data.horses*3 + Save.data.clearedSecret*1 + Save.data.clearedEvil*1
	Save.save_data()
	var completion = Save.data.completion
	$Control/GridContainer/CompletionStat.text = str(completion)+"%"
	if completion >= 100:
		$Control/GridContainer/CompletionStat.modulate = Color8(250,200,20,255)
		$Control/GridContainer/CompletionLabel.modulate = Color8(250,200,20,255)
	
	if Save.data.godgamer == true:
		$Control/HBoxContainer/ModeText.modulate = Color(255,0,0,1)
		$Control/HBoxContainer/ModeLabel.modulate = Color(255,0,0,1)
		$Control/HBoxContainer/ModeText.text = "Godgamer Mode"
	
func calcTime(var elapsed):
	milliseconds = int(elapsed*1000)%1000
	seconds = int(elapsed)%60
	minutes = int(elapsed/60)%60
	hours = int(elapsed/60/60)
	str_elapsed = "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, milliseconds]

func _on_ExitTimer_timeout():
	exit = true

func _on_CreditsAnimationPlayer_animation_finished(_anim_name):
	$Control/AnimationPlayer.play("fade")
	$Control/ExitTimer.start()
