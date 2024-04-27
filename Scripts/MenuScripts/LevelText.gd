extends Label

func _ready():
	var scene = (get_tree().get_current_scene().get_name())
	if scene == "Asylum":
		text = "Mercury Processing Plant"
	if scene == "EvilAsylum":
		text = "Evil"
	if scene == "AsylumBoss":
		text = "Amduat and Nehebkau"
	if scene == "WeebZone":
		text = "Duat"
	if scene == "WeebZoneBoss":
		text = "The Sun"
	if scene == "MadmonqRealm":
		text = "Unknown"
	if scene == "MadmonqRealmBoss":
		text = "Ouroboros"
	if scene == "Secret":
		text = "Extra"
