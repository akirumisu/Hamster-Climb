extends Area2D

var speed = 3.0
var kill

var scene

func _physics_process(_delta):
	position += transform.x * speed
	#position += transform.y * speed

func _enter_tree():
	scene = (get_tree().get_current_scene().get_name())
	if scene == "AsylumBoss":
		var value = $".."/Boss/Peppah.phase
		$AudioStreamPlayer2D.volume_db = (-5) - (value*10)

func _on_Bullet_body_entered(body):
	if body.name == "Player":
		if scene == "AsylumBoss" and $".."/Boss/Nina.killed == true:
			pass
		else:
			$".."/Player.state = $".."/Player.DEATH
