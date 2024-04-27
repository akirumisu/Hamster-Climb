extends Control

var scene

func _ready():
	scene = (get_tree().get_current_scene().get_name())

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and Globalvar.godgamerdeath == false: # On pause menu update stats text
		
		if scene == "Asylum":
			Save.data.checkpointAsylum = Globalvar.checkpointAsylum
			Save.data.AsylumTime += Globalvar.time
		if scene == "EvilAsylum":
			Save.data.checkpointEvilAsylum = Globalvar.checkpointEvilAsylum
			Save.data.AsylumTime += Globalvar.time
		if scene == "WeebZone":
			Save.data.checkpointWeebZone = Globalvar.checkpointWeebZone
			Save.data.WeebZoneTime += Globalvar.time
		if scene == "MadmonqRealm":
			Save.data.checkpointMadmonqRealm = Globalvar.checkpointMadmonqRealm
			Save.data.MadmonqRealmTime += Globalvar.time
		if scene == "AsylumBoss":
			Save.data.AsylumBossTime += Globalvar.time
		if scene == "WeebZoneBoss":
			Save.data.WeebZoneBossTime += Globalvar.time
		if scene == "MadmonqRealmBoss":
			Save.data.MadmonqRealmBossTime += Globalvar.time
		
		Save.data.time += Globalvar.time
		Globalvar.time = 0
		
		var elapsed = int(Save.data.time)
		var seconds = elapsed%60
		var minutes = elapsed/60 %60
		var hours = elapsed/60 /60
		var str_elapsed = "%02d:%02d:%02d" % [hours, minutes, seconds]
		
		$TimeText.text = str(str_elapsed)
		$HorsesText.text = str(Save.data.horses)
		$DeathsText.text = str(Save.data.deaths) # Set death text
