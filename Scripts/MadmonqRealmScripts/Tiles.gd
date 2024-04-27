extends TileMap

var state = 0

func _physics_process(delta):
	if state == 0:
		if name == "Moving1":
			position.x += delta*16
		if name == "Moving2":
			position.x += delta*32
		if name == "Moving3":
			position.x += delta*64
	if state == 1:
		if name == "Moving1":
			position.x -= delta*16
		if name == "Moving2":
			position.x -= delta*32
		if name == "Moving3":
			position.x -= delta*64

func _on_Timer_timeout():
	if state == 0:
		state = 1
	elif state == 1:
		state = 0
