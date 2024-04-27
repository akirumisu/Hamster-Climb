extends Sprite

var move = "left"

func _physics_process(_delta):
	if position.x <= -100:
		move = "left"
		flip_h = true
		rotation = randf()
	if position.x >= 560:
		move = "right"
		flip_h = false
		rotation = randf()
	if position.y <= -60:
		move = "down"
		rotation = randf()
	if position.y >= 340:
		move = "up"
		rotation = randf()
	if move == "right":
		move_local_x(-3)
	if move == "left":
		move_local_x(3)
	if move == "up":
		move_local_y(-3)
	if move == "down":
		move_local_y(3)
