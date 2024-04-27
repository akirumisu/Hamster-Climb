extends TileMap

func _on_PlayerArea2D_body_entered(body):
	if body.name == "Slopes":
		$".."/Player.sloped = true
		$".."/Player.state = $".."/Player.SLIDING

func _on_PlayerArea2D_body_exited(body):
	if body.name == "Slopes":
		$".."/Player.sloped = false
		$".."/Player.state = $".."/Player.SLIDING
