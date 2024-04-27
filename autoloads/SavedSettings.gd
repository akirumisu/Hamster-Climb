extends Node

const SavedSettings = "user://Saves/Settings.save"

var game_data = {}

func _ready():
	load_data()

func load_data():
	var file = File.new()
	if not file.file_exists(SavedSettings):
		game_data = {
			"display_mode": 0,
			"vsync": true,
			"fps_limit": 60,
			"master_vol": 0,
			"music_vol": 0,
			"sfx_vol": 0,
			"speedrun": false,
			"intro": true,
			"animation": true,
			"customInput": false,
			"inputJump": "",
			"inputCancel": "",
			"inputUp": "",
			"inputDown": "",
			"inputLeft": "",
			"inputRight": "",
		}
		save_data()
	file.open(SavedSettings, File.READ)
	game_data = file.get_var()
	file.close()
		
func save_data():
	var file = File.new()
	file.open(SavedSettings, File.WRITE)
	file.store_var(game_data)
	file.close()
