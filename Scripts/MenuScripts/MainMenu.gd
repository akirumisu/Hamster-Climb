extends Control

var quit_delay = 0 # Delay for pressing escape to quit

func _ready():
	$SemitoneTransition/Semitone.In(1) # Fade In
	$StartMenu/VBoxContainer/StartButton.grab_focus() # Grabs focus
	if Globalvar.godgamerdeath == true:
		$despairMusic.play()
		Globalvar.godgamerdeath = false # Reset God Gamer Death Mode
	else:
		$mainmenuMusic.play()

func _physics_process(delta):
	quit_delay += delta
	if Input.is_action_just_pressed("ui_cancel") and $StartMenu/SettingsMenu.visible: # Exit settings
		quit_delay = 0
		$StartMenu/SettingsMenu.visible = false
		$StartMenu/VBoxContainer.visible = true
		$StartMenu/Title.visible = true
		$StartMenu/name.visible = true
		$StartMenu/VBoxContainer/OptionsButton.grab_focus()
	elif Input.is_action_just_pressed("ui_cancel") and $SaveMenu.visible and $SaveMenu/PanelContainer.visible == false: # Exit Savemenu
		$StartMenu/VBoxContainer/StartButton.focus_mode = Control.FOCUS_ALL
		quit_delay = 0
		$FadeTransition/ColorRect/AnimationPlayer.play("fade")
		yield(get_tree().create_timer(0.5), "timeout")
		$SemitoneTransition/Semitone.In(1)
		$SaveMenu.visible = false
		$StartMenu.visible = true
		$StartMenu/VBoxContainer/StartButton.grab_focus()
	elif Input.is_action_just_pressed("ui_cancel") and $KeyBinds.visible == true and $KeyBinds.readyToExit == true:
		quit_delay = 0
		$StartMenu/VBoxContainer.visible = true
		$StartMenu/Title.visible = true
		$StartMenu/name.visible = true
		$KeyBinds.visible = false
		$StartMenu/VBoxContainer/KeybindsButton.grab_focus()
	elif Input.is_action_just_pressed("ui_cancel") and $Credits.visible == true:
		quit_delay = 0
		$StartMenu.visible = true
		$Credits.visible = false
		$StartMenu/VBoxContainer/CreditsButton.grab_focus()
	elif Input.is_action_just_pressed("ui_cancel") and quit_delay > 1 and $SaveMenu/PanelContainer.visible == false and $KeyBinds.visible == false: # Quit out of game
		get_tree().quit()

func _on_StartButton_pressed(): # Gives focus and makes start menu visible
	$FadeTransition/ColorRect/AnimationPlayer.play("fade")
	$StartMenu/VBoxContainer/StartButton.focus_mode = Control.FOCUS_NONE
	yield(get_tree().create_timer(0.5), "timeout")
	$SaveMenu/GridContainer/SaveButton1.grab_focus()
	$SaveMenu.visible = true
	$StartMenu.visible = false

func _on_OptionsButton_pressed(): # Gives focus, makes settings menu visible
	$StartMenu/SettingsMenu.visible = true
	$StartMenu/SettingsMenu/Video/DisplayButton.grab_focus()
	$StartMenu/VBoxContainer.visible = false
	$StartMenu/Title.visible = false
	$StartMenu/name.visible = false

func _on_KeybindsButton_pressed():
	$KeyBinds.visible = true
	$KeyBinds/VBoxContainer/HBox_ui_accept/Button.grab_focus()
	$StartMenu/VBoxContainer.visible = false
	$StartMenu/Title.visible = false
	$StartMenu/name.visible = false

func _on_CreditsButton_pressed():
	$Credits.visible = true
	$StartMenu.visible = false

func _on_QuitButton_pressed(): # Quits out of game
	$SemitoneTransition/Semitone.Out(1)
	$StartMenu/VBoxContainer/QuitButton.focus_mode = Control.FOCUS_NONE
	yield(get_tree().create_timer(0.7), "timeout")
	get_tree().quit()

func _on_StartButton_focus_entered(): # Changing based on what button is hovered
	pass
	#$StartMenu/ColorRect.modulate = Color(150,100,20)

func _on_OptionsButton_focus_entered():
	pass
	#$StartMenu/ColorRect.modulate = Color(20,150,100)

func _on_KeybindsButton_focus_entered():
	pass

func _on_CreditsButton_focus_entered():
	pass
	#$StartMenu/ColorRect.modulate = Color(160,160,0)

func _on_QuitButton_focus_entered():
	pass
	#$StartMenu/ColorRect.modulate = Color(128,255,128)

func _on_StartButton_mouse_entered():
	pass
	#$StartMenu/ColorRect.modulate = Color(150,100,20)

func _on_OptionsButton_mouse_entered():
	pass
	#$StartMenu/ColorRect.modulate = Color(20,150,100)
	
func _on_KeybindsButton_mouse_entered():
	pass

func _on_CreditsButton_mouse_entered():
	pass
	#$StartMenu/ColorRect.modulate = Color(160,160,0)

func _on_QuitButton_mouse_entered():
	pass
	#$StartMenu/ColorRect.modulate = Color(128,255,128)
