extends Node2D

var NEEDLESPEED = 3
var ready = true

var playerposx
var playerposy
var playertracking = false

func _enter_tree():
	NEEDLESPEED = 3

func _physics_process(_delta):
	position += transform.x * NEEDLESPEED
	if NEEDLESPEED <= 0.05:
		queue_free()
	if ready == true:
		ready = false
		look_at($".."/Player.position)
		$Timer.start()
		$Timer2.start()

func _on_Timer_timeout():
	look_at($".."/Player.position)
	NEEDLESPEED = NEEDLESPEED/1.5
	$Timer.start()

func _on_Attack3Needle1_body_entered(body):
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

func _on_Timer2_timeout():
	queue_free()
