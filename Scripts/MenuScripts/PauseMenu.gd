extends Control

func _process(_delta):
	if $".."/".."/Endscreen/Control.visible:
		pass
	elif Input.is_action_just_pressed("ui_cancel") and visible == false and $SettingsMenu.visible == false and $KeyBinds.visible == false and Globalvar.godgamerdeath == false: # Pause
		$VBoxContainer/ResumeButton.grab_focus()
		get_tree().paused = true
		visible = true
		$VBoxContainer.visible = true
	elif Input.is_action_just_pressed("ui_cancel") and $VBoxContainer.visible: # Unpause
		get_tree().paused = false
		visible = false
	elif Input.is_action_just_pressed("ui_cancel") and $SettingsMenu.visible: # Close Settings
		SavedSettings.save_data()
		$VBoxContainer/OptionsButton.grab_focus()
		visible = true
		$VBoxContainer.visible = true
		$SettingsMenu.visible = false
	elif Input.is_action_just_pressed("ui_cancel") and $KeyBinds.visible == true and $KeyBinds.readyToExit == true:
		$VBoxContainer/KeybindsButton.grab_focus()
		visible = true
		$VBoxContainer.visible = true
		$KeyBinds.visible = false
		
func _on_ResumeButton_pressed(): # Resume
	get_tree().paused = false
	visible = false

func _on_RestartButton_pressed(): # Restart 
	get_tree().paused = false
	visible = false
	
	var scene = (get_tree().get_current_scene().get_name()) # Reset saved checkpoint depending on the World
	if scene == "Asylum":
		Save.data.checkpointAsylum = null
		$".."/".."/Player.position = Vector2(176,249)
		Save.data.AsylumTime = 0
	elif scene == "EvilAsylum":
		Save.data.checkpointEvilAsylum = null
		$".."/".."/Player.position = Vector2(176,249)
		Save.data.AsylumTime = 0
	elif scene == "AsylumBoss":
		Save.data.AsylumBossTime = 0
	elif scene == "WeebZone":
		Save.data.checkpointWeebZone = null
		$".."/".."/Player.position = Vector2(130,249)
		Save.data.WeebZoneTime = 0
	elif scene == "WeebZoneBoss":
		Save.data.WeebZoneBossTime = 0
	elif scene == "MadmonqRealm":
		Save.data.checkpointMadmonqRealm = null
		$".."/".."/Player.position = Vector2(73,241)
		Save.data.MadmonqRealmTime = 0
	elif scene == "MadmonqRealmBoss":
		Save.data.MadmonqRealmBossTime = 0
	
	Save.save_data() # Save data
	
	var _error = get_tree().reload_current_scene() # Reload scene

func _on_OptionsButton_pressed(): # Open settings
	$VBoxContainer.visible = false
	$SettingsMenu.visible = true
	$SettingsMenu/Video/DisplayButton.grab_focus()

func _on_KeybindsButton_pressed():
	$VBoxContainer.visible = false
	$KeyBinds.visible = true
	$KeyBinds/VBoxContainer/HBox_ui_accept/Button.grab_focus()

func _on_LevelSelectButton_pressed(): # Switch to LevelSelect scene
	get_tree().paused = false
	var _error = get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")
