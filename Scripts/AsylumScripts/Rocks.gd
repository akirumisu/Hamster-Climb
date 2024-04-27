extends Node2D

func _ready():
	pass

var symbol1
var symbol2
var symbol3
var rightdone = false

var symbol4
var symbol5
var symbol6
var leftdone = false

var rng = RandomNumberGenerator.new()

func _process(_delta):
	if $".."/Boss/Peppah.state == $".."/Boss/Peppah.RESET:
		$RockR.texture = load("res://assets/sprites/benben.png")
		$RockL.texture = load("res://assets/sprites/benben.png")
		rightdone = false
		leftdone = false
		$RockR/Sprite1.visible = false
		$RockR/Sprite2.visible = false
		$RockR/Sprite3.visible = false
		$RockL/Sprite1.visible = false
		$RockL/Sprite2.visible = false
		$RockL/Sprite3.visible = false

func _on_Right2D_body_entered(body):
	if body.name == "Peppah" and $".."/Boss/Peppah.state != $".."/Boss/Peppah.JUMPING:
		$RockR/BloodParticles.emitting = true
	elif body.name == "Peppah" and $".."/Boss/Peppah.state == $".."/Boss/Peppah.JUMPING and rightdone == false:
		$xQcNO.play()
		$RockR/ExplodeParticles.emitting = true
		$RockR.texture = null
		rng.randomize()
		var rng4 = rng.randf_range(0, 1)
		if rng4 > 0.8:
			symbol4 = "5"
		elif rng4 > 0.6:
			symbol4 = "4"
		elif rng4 > 0.4:
			symbol4 = "3"
		elif rng4 > 0.2:
			symbol4 = "2"
		elif rng4 > 0.0:
			symbol4 = "1"
		
		rng.randomize()
		var rng5 = rng.randf_range(0, 1)
		if rng5 > 0.8:
			if symbol4 != "5":
				symbol5 = "5"
			else:
				symbol5 = "4"
		elif rng5 > 0.6:
			if symbol4 != "4":
				symbol5 = "4"
			else:
				symbol5 = "3"
		elif rng5 > 0.4:
			if symbol4 != "3":
				symbol5 = "3"
			else:
				symbol5 = "2"
		elif rng5 > 0.2:
			if symbol4 != "2":
				symbol5 = "2"
			else:
				symbol5 = "1"
		elif rng5 > 0.0:
			if symbol4 != "1":
				symbol5 = "1"
			else:
				symbol5 = "2"
		
		rng.randomize()
		var rng6 = rng.randf_range(0, 1)
		if rng6 > 0.8:
			if symbol4 != "5" and symbol5 != "5":
				symbol6 = "5"
			elif symbol4 != "4" and symbol5 != "4":
				symbol6 = "4"
			else:
				symbol6 = "3"
		elif rng6 > 0.6:
			if symbol4 != "4" and symbol5 != "4":
				symbol6 = "4"
			elif symbol4 != "3" and symbol5 != "3":
				symbol6 = "3"
			else:
				symbol6 = "2"
		elif rng6 > 0.4:
			if symbol4 != "3" and symbol5 != "3":
				symbol6 = "3"
			elif symbol4 != "2" and symbol5 != "2":
				symbol6 = "2"
			else:
				symbol6 = "1"
		elif rng6 > 0.2:
			if symbol4 != "2" and symbol5 != "2":
				symbol6 = "2"
			elif symbol4 != "1" and symbol5 != "1":
				symbol6 = "1"
			else:
				symbol6 = "5"
		elif rng6 > 0.0:
			if symbol4 != "1" and symbol5 != "1":
				symbol6 = "1"
			elif symbol4 != "5" and symbol5 != "5":
				symbol6 = "5"
			else:
				symbol6 = "4"
		
		var string4 = load("res://assets/sprites/rune0"+str(symbol4)+".png")
		var string5 = load("res://assets/sprites/rune0"+str(symbol5)+".png")
		var string6 = load("res://assets/sprites/rune0"+str(symbol6)+".png")
		$RockR/Sprite1.set_texture(string4)
		$RockR/Sprite2.set_texture(string5)
		$RockR/Sprite3.set_texture(string6)
		$RockR/Sprite1.visible = true
		$RockR/Sprite2.visible = true
		$RockR/Sprite3.visible = true
		
		rightdone = true

func _on_Left2D_body_entered(body):
	if body.name == "Peppah" and $".."/Boss/Peppah.state != $".."/Boss/Peppah.JUMPING:
		$RockL/BloodParticles.emitting = true
	elif body.name == "Peppah" and $".."/Boss/Peppah.state == $".."/Boss/Peppah.JUMPING and leftdone == false:
		$xQcNO.play()
		$RockL/ExplodeParticles.emitting = true
		$RockL.texture = null
		rng.randomize()
		var rng1 = rng.randf_range(0, 1)
		if rng1 > 0.8:
			symbol1 = "10"
		elif rng1 > 0.6:
			symbol1 = "9"
		elif rng1 > 0.4:
			symbol1 = "8"
		elif rng1 > 0.2:
			symbol1 = "7"
		elif rng1 > 0.0:
			symbol1 = "6"
		
		rng.randomize()
		var rng2 = rng.randf_range(0, 1)
		if rng2 > 0.8:
			if symbol1 != "10":
				symbol2 = "10"
			else:
				symbol2 = "9"
		elif rng2 > 0.6:
			if symbol1 != "9":
				symbol2 = "9"
			else:
				symbol2 = "8"
		elif rng2 > 0.4:
			if symbol1 != "8":
				symbol2 = "8"
			else:
				symbol2 = "7"
		elif rng2 > 0.2:
			if symbol1 != "7":
				symbol2 = "7"
			else:
				symbol2 = "6"
		elif rng2 > 0.0:
			if symbol1 != "6":
				symbol2 = "6"
			else:
				symbol2 = "7"
		
		rng.randomize()
		var rng3 = rng.randf_range(0, 1)
		if rng3 > 0.8:
			if symbol1 != "10" and symbol2 != "10":
				symbol3 = "10"
			elif symbol1 != "9" and symbol2 != "9":
				symbol3 = "9"
			else:
				symbol3 = "8"
		elif rng3 > 0.6:
			if symbol1 != "9" and symbol2 != "9":
				symbol3 = "9"
			elif symbol1 != "8" and symbol2 != "8":
				symbol3 = "8"
			else:
				symbol3 = "7"
		elif rng3 > 0.4:
			if symbol1 != "8" and symbol2 != "8":
				symbol3 = "8"
			elif symbol1 != "7" and symbol2 != "7":
				symbol3 = "7"
			else:
				symbol3 = "6"
		elif rng3 > 0.2:
			if symbol1 != "7" and symbol2 != "7":
				symbol3 = "7"
			elif symbol1 != "6" and symbol2 != "6":
				symbol3 = "6"
			else:
				symbol3 = "10"
		elif rng3 > 0.0:
			if symbol1 != "6" and symbol2 != "6":
				symbol3 = "6"
			elif symbol1 != "10" and symbol2 != "10":
				symbol3 = "10"
			else:
				symbol3 = "9"
		
		var string1 = load("res://assets/sprites/rune0"+str(symbol1)+".png")
		var string2 = load("res://assets/sprites/rune0"+str(symbol2)+".png")
		var string3 = load("res://assets/sprites/rune0"+str(symbol3)+".png")
		$RockL/Sprite1.set_texture(string1)
		$RockL/Sprite2.set_texture(string2)
		$RockL/Sprite3.set_texture(string3)
		$RockL/Sprite1.visible = true
		$RockL/Sprite2.visible = true
		$RockL/Sprite3.visible = true
		
		leftdone = true

func _on_Area2D_body_entered(body): # SEPERATE THING
	if body.name == "Player":
		$".."/Player.state = $".."/Player.DEATH
