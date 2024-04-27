extends Control

var asylumhorses = 0
var weebzonehorses = 0
var madmonqrealmhorses = 0

var buttoncombo = 0

func _ready():
	Globalvar.deaths = 0
	Globalvar.previoustime = Save.data.time
	Globalvar.horses = 0
	
	$GridContainer/Asylum/AsylumButton.grab_focus() # Grab focus of first world
	if Save.data.clearedAsylum == 1: # Unlock worlds based on cleared save data
		$GridContainer/AsylumBoss/AsylumBossButton.disabled = false
	if Save.data.clearedAsylumBoss == 1:
		$GridContainer/WeebZone/WeebZoneButton.disabled = false
		$GridContainer/WeebZone/Label.visible = true
		$GridContainer/WeebZone/Label2.visible = true
	if Save.data.clearedWeebZone == 1:
		$GridContainer/WeebZoneBoss/WeebZoneBossButton.disabled = false
	if Save.data.clearedWeebZoneBoss == 1:
		$GridContainer/MadmonqRealm/MadmonqRealmButton.disabled = false
		$GridContainer/MadmonqRealm/Label.visible = true
		$GridContainer/MadmonqRealm/Label2.visible = true
	if Save.data.clearedMadmonqRealm == 1:
		$GridContainer/MadmonqRealmBoss/MadmonqRealmBossButton.disabled = false
	
	asylumhorses = Save.data.horse[0] + Save.data.horse[1] + Save.data.horse[2] # Horse counters
	$GridContainer/Asylum/Label2.text = String(asylumhorses)+"/3"
	weebzonehorses = Save.data.horse[3] + Save.data.horse[4] + Save.data.horse[5] # Horse counters
	$GridContainer/WeebZone/Label2.text = String(weebzonehorses)+"/3"
	madmonqrealmhorses = Save.data.horse[6] + Save.data.horse[7] + Save.data.horse[8] # Horse counters
	$GridContainer/MadmonqRealm/Label2.text = String(madmonqrealmhorses)+"/3"
	
	$GridContainer/SecretBoss/Label2.text = String(Save.data.horses)+"/9"
	if Save.data.horses >= 9:
		$GridContainer/SecretBoss/XQCbutton.disabled = false
		$GridContainer/SecretBoss/Label.visible = false
		$GridContainer/SecretBoss/Label2.visible = false
		var milliseconds = int(Save.data.recordSecret*1000)%1000
		var seconds = int(Save.data.recordSecret)%60
		var minutes = int(Save.data.recordSecret/60)%60
		var str_elapsed = "%02d:%02d.%03d" % [minutes, seconds, milliseconds]
		var strtext = str(str_elapsed)
		$GridContainer/SecretBoss/Label3.visible = true
		$GridContainer/SecretBoss/Label3.text = strtext

func _physics_process(_delta):
	Globalvar.previoustime = Save.data.time
	if Input.is_action_just_pressed("ui_cancel"): # Escape returns back to main menu
		var _error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")
	
func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_E) and just_pressed:
		buttoncombo = 1
	if Input.is_key_pressed(KEY_V) and just_pressed and buttoncombo == 1:
		buttoncombo = 2
	if !Input.is_key_pressed(KEY_V) and !Input.is_key_pressed(KEY_E) and just_pressed and buttoncombo == 1:
		buttoncombo = 0
	if Input.is_key_pressed(KEY_I) and just_pressed and buttoncombo == 2:
		buttoncombo = 3
	if !Input.is_key_pressed(KEY_I) and !Input.is_key_pressed(KEY_V) and just_pressed and buttoncombo == 2:
		buttoncombo = 0
	if Input.is_key_pressed(KEY_L) and just_pressed and buttoncombo == 3:
		print("done")
		var _error = get_tree().change_scene("res://Scenes/Asylum/EvilAsylum.tscn")
	if !Input.is_key_pressed(KEY_L) and !Input.is_key_pressed(KEY_I) and just_pressed and buttoncombo == 3:
		buttoncombo = 0

func _on_Button_pressed(): # Exit button
	var _error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")

func _on_AsylumButton_pressed():
	if Save.data.clearedAsylum == 1:
		Save.data.checkpointAsylum = null
		Save.data.timerAsylum = 0
		Save.save_data()
	var _error = get_tree().change_scene("res://Scenes/Asylum/Asylum.tscn")

func _on_AsylumBossButton_pressed():
	if Save.data.clearedAsylumBoss == 1:
		pass
	var _error = get_tree().change_scene("res://Scenes/Asylum/AsylumBoss.tscn")

func _on_WeebZoneButton_pressed():
	if Save.data.clearedWeebZone == 1:
		Save.data.checkpointWeebZone = null
		Save.data.timerWeebZone = 0
		Save.save_data()
	var _error = get_tree().change_scene("res://Scenes/WeebZone/WeebZone.tscn")

func _on_WeebZoneBossButton_pressed():
	if Save.data.clearedWeebZoneBoss == 1:
		pass
	var _error = get_tree().change_scene("res://Scenes/WeebZone/WeebZoneBoss.tscn")

func _on_MadmonqRealmButton_pressed():
	if Save.data.clearedMadmonqRealm == 1:
		Save.data.checkpointMadmonqRealm = null
		Save.data.timerMadmonqRealm = 0
		Save.save_data()
	var _error = get_tree().change_scene("res://Scenes/MadmonqRealm/MadmonqRealm.tscn")

func _on_MadmonqRealmBossButton_pressed():
	if Save.data.clearedMadmonqRealmBoss == 1:
		pass
	var _error = get_tree().change_scene("res://Scenes/MadmonqRealm/MadmonqRealmBoss.tscn")

func _on_XQCbutton_pressed():
	if Save.data.clearedSecret == 1:
		pass
	var _error = get_tree().change_scene("res://Scenes/Secret/Secret.tscn")
