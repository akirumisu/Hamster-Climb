extends TileMap

var tilestoofar = false

var turn = 1

func _process(delta):
	if $".."/xqc.health > 0:
		if position.x >= 900:
			tilestoofar = true
		if position.x<= 600:
			tilestoofar = false
			
		if tilestoofar == true:
			position.x -= delta*50
			$".."/MovingTilesInfinite2.position.x -= delta*50
		elif tilestoofar == false:
			position.x += delta*50
			$".."/MovingTilesInfinite2.position.x += delta*50
	
	if turn == 1:
		if $".."/Player.position.y < position.y:
			position.y = position.y - 672
			turn = 2
	if turn == 2:
		if $".."/Player.position.y < $".."/MovingTilesInfinite2.position.y - 1000:
			$".."/MovingTilesInfinite2.position.y = $".."/MovingTilesInfinite2.position.y - 672
			turn = 1
