extends Node2D

var NEEDLESPEED = 3
var ready = true

func _enter_tree():
	NEEDLESPEED = 3

func _physics_process(_delta):
	$Attack3Needle1.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle1.rotation)
	$Attack3Needle2.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle2.rotation)
	$Attack3Needle3.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle3.rotation)
	$Attack3Needle4.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle4.rotation)
	$Attack3Needle5.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle5.rotation)
	$Attack3Needle6.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle6.rotation)
	$Attack3Needle7.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle7.rotation)
	$Attack3Needle8.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle8.rotation)
	$Attack3Needle9.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle9.rotation)
	$Attack3Needle10.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle10.rotation)
	$Attack3Needle11.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle11.rotation)
	$Attack3Needle12.position += Vector2(NEEDLESPEED,0).rotated($Attack3Needle12.rotation)
	if ready == true:
		ready = false
		$Timer.start()

func _on_Timer_timeout():
	queue_free()

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
