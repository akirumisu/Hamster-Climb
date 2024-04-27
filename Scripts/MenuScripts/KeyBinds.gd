extends Control

var can_change_key = false
var action_string
enum ACTIONS {ui_accept, ui_cancel, ui_up, ui_down, ui_left, ui_right}

var readyToExit = true

func _ready():
	var ev = InputEventKey.new()
	SavedSettings.load_data() # Load settings file
	if SavedSettings.game_data.customInput == true: # If customInput
		ev.scancode = OS.find_scancode_from_string(SavedSettings.game_data.inputJump)
		InputMap.get_action_list("ui_accept")[0].scancode = ev.scancode
		ev.scancode = OS.find_scancode_from_string(SavedSettings.game_data.inputCancel)
		InputMap.get_action_list("ui_cancel")[0].scancode = ev.scancode
		ev.scancode = OS.find_scancode_from_string(SavedSettings.game_data.inputUp)
		InputMap.get_action_list("ui_up")[0].scancode = ev.scancode
		ev.scancode = OS.find_scancode_from_string(SavedSettings.game_data.inputDown)
		InputMap.get_action_list("ui_down")[0].scancode = ev.scancode
		ev.scancode = OS.find_scancode_from_string(SavedSettings.game_data.inputLeft)
		InputMap.get_action_list("ui_left")[0].scancode = ev.scancode
		ev.scancode = OS.find_scancode_from_string(SavedSettings.game_data.inputRight)
		InputMap.get_action_list("ui_right")[0].scancode = ev.scancode
	_set_keys()

func _process(_delta):
	if readyToExit == false:
		$WarningLabel.visible = true
		$SaveButton.modulate = Color8(100,100,100,255)
	else:
		$WarningLabel.visible = false
		$SaveButton.modulate = Color8(255,255,255,255)
  
func _set_keys():
	readyToExit = true
	for j in ACTIONS:
		get_node("VBoxContainer/HBox_" + str(j) + "/Button").set_pressed(false)
		if !InputMap.get_action_list(j).empty():
			get_node("VBoxContainer/HBox_" + str(j) + "/Button").set_text(InputMap.get_action_list(j)[0].as_text())
			get_node("VBoxContainer/HBox_" + str(j) + "/Button").modulate = Color8(255,255,255,255)
		else:
			get_node("VBoxContainer/HBox_" + str(j) + "/Button").set_text("Unbound")
			get_node("VBoxContainer/HBox_" + str(j) + "/Button").modulate = Color8(255,50,50,255)
			readyToExit = false

func _on_SaveButton_pressed():
	for j in ACTIONS:
		get_node("VBoxContainer/HBox_" + str(j) + "/Button").set_pressed(false)
		if !InputMap.get_action_list(j).empty():
			pass
		else:
			readyToExit = false
	if readyToExit == true:
		SavedSettings.game_data.customInput = true
		# Save keys
		SavedSettings.game_data.inputJump   = OS.get_scancode_string(InputMap.get_action_list("ui_accept")[0].scancode)
		SavedSettings.game_data.inputCancel = OS.get_scancode_string(InputMap.get_action_list("ui_cancel")[0].scancode)
		SavedSettings.game_data.inputUp     = OS.get_scancode_string(InputMap.get_action_list("ui_up")[0].scancode)
		SavedSettings.game_data.inputDown   = OS.get_scancode_string(InputMap.get_action_list("ui_down")[0].scancode)
		SavedSettings.game_data.inputLeft   = OS.get_scancode_string(InputMap.get_action_list("ui_left")[0].scancode)
		SavedSettings.game_data.inputRight  = OS.get_scancode_string(InputMap.get_action_list("ui_right")[0].scancode)
		SavedSettings.save_data()
		# Exit
		Input.action_press("ui_cancel")

func _on_ui_accept_pressed():
	_mark_button("ui_accept")

func _on_ui_cancel_pressed():
	_mark_button("ui_cancel")

func _on_ui_up_pressed():
	_mark_button("ui_up")

func _on_ui_down_pressed():
	_mark_button("ui_down")

func _on_ui_left_pressed():
	_mark_button("ui_left")

func _on_ui_right_pressed():
	_mark_button("ui_right")

func _mark_button(string):
	can_change_key = true
	action_string = string
	for j in ACTIONS:
		if j != string:
			get_node("VBoxContainer/HBox_" + str(j) + "/Button").set_pressed(false)

func _input(event):
	if event is InputEventKey: 
		if can_change_key:
			_change_key(event)
			can_change_key = false

func _change_key(new_key):
	$CooldownTimer.start()
	
	# Check if new key was assigned somewhere
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
	# Delete key of pressed button
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	# Add new Key
	InputMap.action_add_event(action_string, new_key)
	
	_set_keys()

func _on_CooldownTimer_timeout():
	can_change_key = false
	for j in ACTIONS:
		get_node("VBoxContainer/HBox_" + str(j) + "/Button").set_pressed(false)
		
