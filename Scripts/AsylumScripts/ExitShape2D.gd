extends CollisionShape2D

var exiting = false

func _on_ExitArea2D_body_entered(body):
	if body.name == "Player":
		exiting = true
		$".."/Timer.start()

func _physics_process(_delta):
	if exiting == true:
		$".."/".."/Player.velocity.y = -100

func _on_Timer_timeout():
	$".."/".."/Endscreen/Control.visible = true
