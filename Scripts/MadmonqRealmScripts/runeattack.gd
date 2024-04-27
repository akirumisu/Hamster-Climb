extends Node2D

var NEEDLESPEED = 3
var ready = true

func _enter_tree():
	NEEDLESPEED = 3

func _physics_process(_delta):
	position += transform.x * NEEDLESPEED
	#scale += Vector2(delta*2,delta*2)
	if ready == true:
		ready = false
		$Timer.start()

func _on_Timer_timeout():
	queue_free()

func _on_Attack1Needle1_body_entered(body):
	if body.name == "Player":
		if modulate == Color(255,0,0):
			$".."/Player/color.red += 1
			$".."/Player/color/red.amount = $".."/Player/color.red
			$".."/Player/color.redlabel = true
		if modulate == Color(0,255,0):
			$".."/Player/color.green += 1
			$".."/Player/color/green.amount = $".."/Player/color.green
			$".."/Player/color.greenlabel = true
		if modulate == Color(0,150,255):
			$".."/Player/color.blue += 1
			$".."/Player/color/blue.amount = $".."/Player/color.blue
			$".."/Player/color.bluelabel = true
		if modulate == Color(255,0,255):
			$".."/Player/color.purple += 1
			$".."/Player/color/purple.amount = $".."/Player/color.purple
			$".."/Player/color.purplelabel = true
		if modulate == Color(255,255,0):
			$".."/Player/color.yellow += 1
			$".."/Player/color/yellow.amount = $".."/Player/color.yellow
			$".."/Player/color.yellowlabel = true
		queue_free()
