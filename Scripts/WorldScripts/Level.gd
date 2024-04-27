extends Node2D

var scene

func _ready():
	
	if SavedSettings.game_data:
		Globalvar.speedrunsettings = SavedSettings.game_data.speedrun
		Globalvar.introsettings = SavedSettings.game_data.intro
		Globalvar.animationsettings = SavedSettings.game_data.animation
	
	$CanvasLayer/Transition/AnimationPlayer.play("fade_in") # Play fade_in animation
	
	$Player/PlayerSprite.play("walkright")
	
	scene = (get_tree().get_current_scene().get_name())
	
	Save.load_data() # Load data
	scene = (get_tree().get_current_scene().get_name()) # Set players position to save file checkpoint of the world
	if scene == "Asylum":
		$Player.bosslevel = false
		if Save.data.checkpointAsylum:
			$Player.global_position = Save.data.checkpointAsylum
	elif scene == "EvilAsylum":
		$Player.bosslevel = false
		if Save.data.checkpointEvilAsylum:
			$Player.global_position = Save.data.checkpointEvilAsylum
	elif scene == "WeebZone":
		$Player.bosslevel = false
		if Save.data.checkpointWeebZone:
			$Player.global_position = Save.data.checkpointWeebZone
	elif scene == "MadmonqRealm":
		$Player.bosslevel = false
		if Save.data.checkpointMadmonqRealm:
			$Player.global_position = Save.data.checkpointMadmonqRealm
	elif scene == "Secret":
		$Player.bosslevel = false
	else:
		$Player.bosslevel = true
	
func _on_AnimationPlayer_animation_finished(animation): # Trigger when the death animation plays
	if animation == "fade_out":
		if Globalvar.godgamerdeath == true:
			var _error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")
		else:
			var _error = get_tree().reload_current_scene() # Reload scene

func _exit_tree():
	if scene == "Asylum" or scene == "EvilAsylum" or scene == "WeebZone" or scene == "MadmonqRealm":
		pass
	elif $Player.state == $Player.DEATH:
		Globalvar.deaths += 1
		if scene == "AsylumBoss":
			Save.data.AsylumBossDeaths += 1
		if scene == "WeebZoneBoss":
			Save.data.WeebZoneBossDeaths += 1
		if scene == "MadmonqRealmBoss":
			Save.data.MadmonqRealmBossDeaths += 1
		
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
		
	if Globalvar.godgamerdeath == true:
		Save.data.failedsave = true
		Save.save_data()
	else:
		Save.data.time += Globalvar.time
		Globalvar.time = 0
		Save.save_data() # Save files

var ready = true

func _physics_process(delta):
	
	Globalvar.time += delta
	
	if scene == "Secret":
		ready = false
	
	if scene == "Asylum":
		Globalvar.checkpointAsylum = $Player.global_position
	if scene == "EvilAsylum":
		Globalvar.checkpointEvilAsylum = $Player.global_position
	if scene == "WeebZone":
		Globalvar.checkpointWeebZone = $Player.global_position
	if scene == "MadmonqRealm":
		Globalvar.checkpointMadmonqRealm = $Player.global_position
		
	if (Globalvar.godgamerdeath == true and ready == true):
		yield(get_tree().create_timer(5), "timeout")
		$CanvasLayer/Transition/AnimationPlayer.play("fade_out")
		$CanvasLayer/Transition/AnimationPlayer.playback_speed = 0.1
		ready = false
