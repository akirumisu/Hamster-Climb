extends Control

func _ready():
	$Untitled2/AnimationPlayer.play("Splash Sceen")
	Save.load_data()
	Save.save_data()
	SavedSettings.load_data()
	SavedSettings.save_data()
	if SavedSettings.game_data.intro == false:
		var _error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")

func _on_Timer1_timeout():
	$Control.visible = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if $Control.visible == false:
			$Control.visible = true
		else:
			var _error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")
