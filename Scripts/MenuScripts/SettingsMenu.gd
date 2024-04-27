extends Control

#video settings
onready var display_options = $Video/DisplayButton
onready var vsync = $Video/VSyncButton
onready var fps_limit = $Video/FPSSlider
onready var fps_text = $Video/FPSText

#audio settings
onready var master_volume = $Audio/MasterSlider
onready var music_volume = $Audio/MusicSlider
onready var sfx_volume = $Audio/SFXSlider
onready var master_text = $Audio/MasterVolume/MasterText
onready var music_text = $Audio/MusicVolume/MusicText
onready var sfx_text = $Audio/SFXVolume/SFXVolume

#gameplay settings
onready var speedrun = $Gameplay/SpeedrunButton
onready var intro = $Gameplay/IntroButton
onready var animation = $Gameplay/AnimationButton

func _ready():
	SavedSettings.load_data() # Load settings file
	
	display_options.select(SavedSettings.game_data.display_mode) # Change visual settings and then calls its functions
	window(SavedSettings.game_data.display_mode)
	vsync.pressed = SavedSettings.game_data.vsync
	toggle_vsync(SavedSettings.game_data.vsync)
	fps_limit.value = SavedSettings.game_data.fps_limit
	update_fps(SavedSettings.game_data.fps_limit)
	
	master_volume.value = SavedSettings.game_data.master_vol
	update_master_vol(SavedSettings.game_data.master_vol)
	music_volume.value = SavedSettings.game_data.music_vol
	update_music_vol(SavedSettings.game_data.music_vol)
	sfx_volume.value = SavedSettings.game_data.sfx_vol
	update_sfx_vol(SavedSettings.game_data.sfx_vol)
	
	speedrun.pressed = SavedSettings.game_data.speedrun
	toggle_vsync(SavedSettings.game_data.vsync)
	intro.pressed = SavedSettings.game_data.intro
	toggle_vsync(SavedSettings.game_data.vsync)
	animation.pressed = SavedSettings.game_data.animation
	toggle_vsync(SavedSettings.game_data.vsync)
	
func _on_DisplayButton_item_selected(index): # On setting update call function
	window(index)

func _on_VSyncButton_toggled(value):
	toggle_vsync(value)

func _on_FPSSlider_value_changed(value):
	update_fps(value)
	fps_text.text = str(value)

func _on_MasterSlider_value_changed(vol):
	update_master_vol(vol)

func _on_MusicSlider_value_changed(vol):
	update_music_vol(vol)

func _on_SFXSlider_value_changed(vol):
	update_sfx_vol(vol)

func _on_SpeedrunButton_toggled(value):
	toggle_speedrun(value)

func _on_IntroButton_toggled(value):
	toggle_intro(value)

func _on_AnimationButton_toggled(value):
	toggle_animation(value)

func window(value): # functions to make the settings work + saves it to file
	if value == 0:
		OS.window_maximized = false
		OS.window_fullscreen = false
		OS.window_borderless = false
	if value == 1:
		OS.window_fullscreen = false
		OS.window_borderless = true
		OS.window_maximized = true
	if value == 2:
		OS.window_fullscreen = true
		OS.window_borderless = false
		OS.window_maximized = false
	SavedSettings.game_data.display_mode = value
	SavedSettings.save_data()

func toggle_vsync(value):
	if value == true:
		OS.vsync_enabled = true
	if value == false:
		OS.vsync_enabled = false
	SavedSettings.game_data.vsync = value
	SavedSettings.save_data()

func update_fps(value):
	Engine.target_fps = value
	SavedSettings.game_data.fps_limit = value
	SavedSettings.save_data()

func update_master_vol(vol):
	if master_volume.value == -20:
		AudioServer.set_bus_mute(0,true)
		master_text.text = "OFF"
	else:
		AudioServer.set_bus_mute(0,false)
		master_text.text = str(vol)
	AudioServer.set_bus_volume_db(0, vol)
	SavedSettings.game_data.master_vol = vol
	SavedSettings.save_data()

func update_music_vol(vol):
	if music_volume.value == -20:
		AudioServer.set_bus_mute(1,true)
		music_text.text = "OFF"
	else:
		AudioServer.set_bus_mute(1,false)
		music_text.text = str(vol)
	AudioServer.set_bus_volume_db(1, vol)
	SavedSettings.game_data.music_vol = vol
	SavedSettings.save_data()

func update_sfx_vol(vol):
	if sfx_volume.value == -20:
		AudioServer.set_bus_mute(2,true)
		sfx_text.text = "OFF"
	else:
		AudioServer.set_bus_mute(2,false)
		sfx_text.text = str(vol)
	AudioServer.set_bus_volume_db(2, vol)
	SavedSettings.game_data.sfx_vol = vol
	SavedSettings.save_data()

func toggle_speedrun(value):
	if value == true:
		Globalvar.speedrunsettings = true
	if value == false:
		Globalvar.speedrunsettings = false
	SavedSettings.game_data.speedrun = value
	SavedSettings.save_data()

func toggle_intro(value):
	if value == true:
		pass
	if value == false:
		pass
	SavedSettings.game_data.intro = value
	SavedSettings.save_data()

func toggle_animation(value):
	if value == true:
		Globalvar.animationsettings = true
	if value == false:
		Globalvar.animationsettings = false
	SavedSettings.game_data.animation = value
	SavedSettings.save_data()

func _physics_process(_delta): # Change Tabs and Set FPS
	$Video/FPSCounter.text = "fps: " + str(Engine.get_frames_per_second())
