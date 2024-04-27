extends Node

const save_folder = "user://Saves/save"
var save_path = "user://Saves/save.dat"

var data = {}

func _ready():
	load_data()

func load_data():
	var file = File.new()
	if not file.file_exists(save_path):
		var dir = Directory.new()
		dir.open("user://")
		dir.make_dir("Saves")
		data = {
			"time": 0,
			"horses": 0,
			"deaths": 0,
			"completion": 0,
			"newfile": true,
			"godgamer": false,
			"clearedAsylum": 0,
			"checkpointAsylum": null,
			"checkpointEvilAsylum": null,
			"AsylumTime": 0,
			"clearedAsylumBoss": 0,
			"AsylumBossDeaths": 0,
			"AsylumBossTime": 0,
			"clearedWeebZone": 0,
			"WeebZoneTime": 0,
			"checkpointWeebZone": null,
			"clearedWeebZoneBoss": 0,
			"WeebZoneBossDeaths": 0,
			"WeebZoneBossTime": 0,
			"clearedMadmonqRealm": 0,
			"MadmonqRealmTime": 0,
			"checkpointMadmonqRealm": null,
			"clearedMadmonqRealmBoss": 0,
			"MadmonqRealmBossDeaths": 0,
			"MadmonqRealmBossTime": 0,
			"clearedSecret": 0,
			"recordSecret": 0,
			"clearedEvil": 0,
			"timerAsylum": 0,
			"timerWeebZone": 0,
			"timerMadmonqRealm": 0,
			"failedsave": false,
			"horse": [0,0,0,0,0,0,0,0,0],
		}
		save_data()
	file.open_encrypted_with_pass(save_path, File.READ, "bgltym8gaxmgcmvhba")
	data = file.get_var()
	file.close()
		
func save_data():
	var file = File.new()
	file.open_encrypted_with_pass(save_path, File.WRITE, "bgltym8gaxmgcmvhba")
	file.store_var(data)
	file.close()

func setSaveSlot(slot):
	data = {}
	save_path = save_folder + str(slot)
