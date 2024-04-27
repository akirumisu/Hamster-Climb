extends Control

func _ready():
	Save.data.completion = (Save.data.clearedAsylum + Save.data.clearedAsylumBoss + Save.data.clearedWeebZone + Save.data.clearedWeebZoneBoss + Save.data.clearedMadmonqRealm + Save.data.clearedMadmonqRealmBoss)*12 + Save.data.horses*3 + Save.data.clearedSecret*1 + Save.data.clearedEvil*1
	Save.save_data()

func _on_SaveButton1_pressed(): # Set saveslot1
	$GridContainer/SaveButton1.focus_mode = Control.FOCUS_NONE
	Save.setSaveSlot(1)
	Globalvar.saveslot = 1
	Save.load_data()
	if Save.data.failedsave == true:
		$GridContainer/DeleteButton1.grab_focus()
		$GridContainer/SaveButton1.focus_mode = Control.FOCUS_ALL
	elif Save.data.newfile == false: # If old file, load straight up
		if Save.data.failedsave == false:
			$"../FadeTransition/ColorRect/AnimationPlayer".play("fade")
			yield(get_tree().create_timer(0.5), "timeout")
			var _error = get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")
	else:
		$GridContainer.visible = false
		$PanelContainer.visible = true
		$PanelContainer/GridContainer/StandardButton.grab_focus()
	
func _on_SaveButton2_pressed(): # Set saveslot2
	$GridContainer/SaveButton2.focus_mode = Control.FOCUS_NONE
	Save.setSaveSlot(2)
	Globalvar.saveslot = 2
	Save.load_data()
	if Save.data.failedsave == true:
		$GridContainer/DeleteButton2.grab_focus()
		$GridContainer/SaveButton1.focus_mode = Control.FOCUS_ALL
	elif Save.data.newfile == false: # If old file, load straight up
		if Save.data.failedsave == false:
			$"../FadeTransition/ColorRect/AnimationPlayer".play("fade")
			yield(get_tree().create_timer(0.5), "timeout")
			var _error = get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")
	else:
		$GridContainer.visible = false
		$PanelContainer.visible = true
		$PanelContainer/GridContainer/StandardButton.grab_focus()

func _on_SaveButton3_pressed(): # Set saveslot3
	$GridContainer/SaveButton3.focus_mode = Control.FOCUS_NONE
	Save.setSaveSlot(3)
	Globalvar.saveslot = 3
	Save.load_data()
	if Save.data.failedsave == true:
		$GridContainer/DeleteButton3.grab_focus()
		$GridContainer/SaveButton1.focus_mode = Control.FOCUS_ALL
	elif Save.data.newfile == false: # If old file, load straight up
		if Save.data.failedsave == false:
			$"../FadeTransition/ColorRect/AnimationPlayer".play("fade")
			yield(get_tree().create_timer(0.5), "timeout")
			var _error = get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")
	else:
		$GridContainer.visible = false
		$PanelContainer.visible = true
		$PanelContainer/GridContainer/StandardButton.grab_focus()

func _on_StandardButton_pressed(): # Select standard difficulty
	$PanelContainer/GridContainer/StandardButton.focus_mode = Control.FOCUS_NONE
	$"../FadeTransition/ColorRect/AnimationPlayer".play("fade")
	Save.data.newfile = false
	Save.save_data()
	yield(get_tree().create_timer(0.5), "timeout")
	var _error = get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")

func _on_GodGamerButton_pressed(): # Select god gamer difficulty
	$PanelContainer/GridContainer/GodGamerButton.focus_mode = Control.FOCUS_NONE
	$"../FadeTransition/ColorRect/AnimationPlayer".play("fade")
	Save.data.newfile = false
	Save.data.godgamer = true
	Save.save_data()
	yield(get_tree().create_timer(0.5), "timeout")
	var _error = get_tree().change_scene("res://Scenes/Menus/LevelSelect.tscn")

func _on_StartButton_pressed(): # When the start button is pressed
	$GridContainer/SaveButton1.focus_mode = Control.FOCUS_ALL
	$GridContainer/SaveButton2.focus_mode = Control.FOCUS_ALL
	$GridContainer/SaveButton3.focus_mode = Control.FOCUS_ALL
	$PanelContainer/GridContainer/StandardButton.focus_mode = Control.FOCUS_ALL
	$PanelContainer/GridContainer/GodGamerButton.focus_mode = Control.FOCUS_ALL
	updatesave1()
	updatesave2()
	updatesave3()

func updatesave1():
	Save.setSaveSlot(1) # Load saveslot1
	Save.load_data()
	var elapsed1 = int(Save.data.time)
	var seconds1 = elapsed1%60
	var minutes1 = elapsed1/60 %60
	var hours1 = elapsed1/60 /60
	var str_elapsed1 = "%02d:%02d:%02d" % [hours1, minutes1, seconds1]
	$GridContainer/Save1Time.text = str(str_elapsed1)
	$GridContainer/Save1Horses.text = str(Save.data.horses)
	$GridContainer/Save1Deaths.text = str(Save.data.deaths)
	var percent1 = Save.data.completion
	$GridContainer/Save1Special.text = str(percent1)
	if percent1 >= 100:
		$GridContainer/Save1Special.modulate = Color8(250,200,20,255)
	if Save.data.newfile:
		$GridContainer/DeleteButton1.disabled = true
		$GridContainer/SaveButton1.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/SaveButton1.add_color_override("font_color_focus",Color(1,1,1))
		$GridContainer/SaveButton1.text = "Save File 1"
		$GridContainer/Save1Time.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save1Horses.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save1Deaths.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save1Special.add_color_override("font_color",Color(0.4,0.4,0.4))
	elif Save.data.failedsave == true:
		$GridContainer/SaveButton1.text = "DEAD"
		var dir = Directory.new()
		dir.remove("user://Saves/save.1")
		Save.setSaveSlot(2)
		Save.load_data()
	elif Save.data.godgamer == true:
		$GridContainer/SaveButton1.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/SaveButton1.add_color_override("font_color_focus",Color(1,0,0))
		$GridContainer/SaveButton1.add_color_override("font_color_pressed",Color(0.5,0,0))
		$GridContainer/SaveButton1.text = "GOD GAMER"
		$GridContainer/Save1Time.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save1Horses.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save1Deaths.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save1Special.add_color_override("font_color",Color(0.7,0,0))
	else:
		$GridContainer/SaveButton1.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/SaveButton1.add_color_override("font_color_focus",Color(1,1,1))
		$GridContainer/SaveButton1.text = "STANDARD"
		$GridContainer/Save1Time.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save1Horses.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save1Deaths.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save1Special.add_color_override("font_color",Color(0.7,0.7,0.7))

func updatesave2():
	Save.setSaveSlot(2) # Load saveslot2
	Save.load_data()
	var elapsed2 = int(Save.data.time)
	var seconds2 = elapsed2%60
	var minutes2 = elapsed2/60 %60
	var hours2 = elapsed2/60 /60
	var str_elapsed2 = "%02d:%02d:%02d" % [hours2, minutes2, seconds2]
	$GridContainer/Save2Time.text = str(str_elapsed2)
	$GridContainer/Save2Horses.text = str(Save.data.horses)
	$GridContainer/Save2Deaths.text = str(Save.data.deaths)
	var percent2 = Save.data.completion
	$GridContainer/Save2Special.text = str(percent2)
	if percent2 >= 100:
		$GridContainer/Save2Special.modulate = Color8(250,200,20,255)
	if Save.data.newfile:
		$GridContainer/DeleteButton2.disabled = true
		$GridContainer/SaveButton2.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/SaveButton2.add_color_override("font_color_focus",Color(1,1,1))
		$GridContainer/SaveButton2.text = "Save File 2"
		$GridContainer/Save2Time.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save2Horses.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save2Deaths.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save2Special.add_color_override("font_color",Color(0.4,0.4,0.4))
	elif Save.data.failedsave == true:
		$GridContainer/SaveButton2.text = "DEAD"
		var dir = Directory.new()
		dir.remove("user://Saves/save.2")
		Save.setSaveSlot(2)
		Save.load_data()
	elif Save.data.godgamer == true:
		$GridContainer/SaveButton2.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/SaveButton2.add_color_override("font_color_focus",Color(1,0,0))
		$GridContainer/SaveButton2.add_color_override("font_color_pressed",Color(0.5,0,0))
		$GridContainer/SaveButton2.text = "GOD GAMER"
		$GridContainer/Save2Time.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save2Horses.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save2Deaths.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save2Special.add_color_override("font_color",Color(0.7,0,0))
	else:
		$GridContainer/SaveButton2.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/SaveButton2.add_color_override("font_color_focus",Color(1,1,1))
		$GridContainer/SaveButton2.text = "STANDARD"
		$GridContainer/Save2Time.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save2Horses.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save2Deaths.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save2Special.add_color_override("font_color",Color(0.7,0.7,0.7))

func updatesave3():
	Save.setSaveSlot(3) # Load saveslot3
	Save.load_data()
	var elapsed3 = int(Save.data.time)
	var seconds3 = elapsed3%60
	var minutes3 = elapsed3/60 %60
	var hours3 = elapsed3/60 /60
	var str_elapsed3 = "%02d:%02d:%02d" % [hours3, minutes3, seconds3]
	$GridContainer/Save3Time.text = str(str_elapsed3)
	$GridContainer/Save3Horses.text = str(Save.data.horses)
	$GridContainer/Save3Deaths.text = str(Save.data.deaths)
	var percent3 = Save.data.completion
	$GridContainer/Save3Special.text = str(percent3)
	if percent3 >= 100:
		$GridContainer/Save3Special.modulate = Color8(250,200,20,255)
	if Save.data.newfile:
		$GridContainer/DeleteButton3.disabled = true
		$GridContainer/SaveButton3.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/SaveButton3.add_color_override("font_color_focus",Color(1,1,1))
		$GridContainer/SaveButton3.text = "Save File 3"
		$GridContainer/Save3Time.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save3Horses.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save3Deaths.add_color_override("font_color",Color(0.4,0.4,0.4))
		$GridContainer/Save3Special.add_color_override("font_color",Color(0.4,0.4,0.4))
	elif Save.data.failedsave == true:
		$GridContainer/SaveButton3.text = "DEAD"
		var dir = Directory.new()
		dir.remove("user://Saves/save.3")
		Save.setSaveSlot(2)
		Save.load_data()
	elif Save.data.godgamer == true:
		$GridContainer/SaveButton3.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/SaveButton3.add_color_override("font_color_focus",Color(1,0,0))
		$GridContainer/SaveButton3.add_color_override("font_color_pressed",Color(0.5,0,0))
		$GridContainer/SaveButton3.text = "GOD GAMER"
		$GridContainer/Save3Time.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save3Horses.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save3Deaths.add_color_override("font_color",Color(0.7,0,0))
		$GridContainer/Save3Special.add_color_override("font_color",Color(0.7,0,0))
	else:
		$GridContainer/SaveButton3.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/SaveButton3.add_color_override("font_color_focus",Color(1,1,1))
		$GridContainer/SaveButton3.text = "STANDARD"
		$GridContainer/Save3Time.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save3Horses.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save3Deaths.add_color_override("font_color",Color(0.7,0.7,0.7))
		$GridContainer/Save3Special.add_color_override("font_color",Color(0.7,0.7,0.7))

var saveslot

func _on_DeleteButton1_pressed():
	$DeleteConfirmation.popup()
	saveslot = 1

func _on_DeleteButton2_pressed():
	$DeleteConfirmation.popup()
	saveslot = 2

func _on_DeleteButton3_pressed():
	$DeleteConfirmation.popup()
	saveslot = 3

func _on_DeleteConfirmation_confirmed():
	var dir = Directory.new()
	dir.remove("user://Saves/save" + str(saveslot))
	updatesave1()
	updatesave2()
	updatesave3()
