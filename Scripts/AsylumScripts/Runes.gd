extends Node2D

var rune10active; var rune9active; var rune8active; var rune7active; var rune6active;
var rune5active; var rune4active; var rune3active; var rune2active; var rune1active

var correct = 0
var wrong = 0

var oneshot1 = true; var oneshot2 = true; var oneshot3 = true; var oneshot4 = true; var oneshot5 = true;
var oneshot6 = true; var oneshot7 = true; var oneshot8 = true; var oneshot9 = true; var oneshot10 = true;
var oneshotcorrect = true

var rock1shot = true
var rock2shot = true

func _process(_delta):
	if $".."/Boss/Peppah.state == $".."/Boss/Peppah.RESET:
		oneshot1 = true; oneshot2 = true; oneshot3 = true; oneshot4 = true; oneshot5 = true;
		oneshot6 = true; oneshot7 = true; oneshot8 = true; oneshot9 = true; oneshot10 = true;
		oneshotcorrect = true
		rock1shot = true
		rock2shot = true
		correct = 0
		$DestroyRune.visible = false
		$DestroyRune2.visible = false
	
	if $".."/Rocks.rightdone and rock1shot == true:
		rock1shot = false
		var s4 = $".."/Rocks.symbol4
		var s5 = $".."/Rocks.symbol5
		var s6 = $".."/Rocks.symbol6
		if s4 == "5" or s5 == "5" or s6 == "5":
			rune5active = true
		if s4 == "4" or s5 == "4" or s6 == "4":
			rune4active = true
		if s4 == "3" or s5 == "3" or s6 == "3":
			rune3active = true
		if s4 == "2" or s5 == "2" or s6 == "2":
			rune2active = true
		if s4 == "1" or s5 == "1" or s6 == "1":
			rune1active = true
	
	if $".."/Rocks.leftdone and rock2shot == true:
		rock2shot = false
		var s1 = $".."/Rocks.symbol1
		var s2 = $".."/Rocks.symbol2
		var s3 = $".."/Rocks.symbol3
		if s1 == "10" or s2 == "10" or s3 == "10":
			rune10active = true
		if s1 == "9" or s2 == "9" or s3 == "9":
			rune9active = true
		if s1 == "8" or s2 == "8" or s3 == "8":
			rune8active = true
		if s1 == "7" or s2 == "7" or s3 == "7":
			rune7active = true
		if s1 == "6" or s2 == "6" or s3 == "6":
			rune6active = true
	
	if wrong == 1:
		$".."/Player.state = $".."/Player.DEATH
	
	if correct == 6 and oneshotcorrect:
		$buffsound.play()
		oneshotcorrect = false
		$".."/Player/MEGA.emitting = true
		if rune1active == true:
			$RuneL1/BlueParticles.emitting = false
			$RuneL1/Blue2Particles.emitting = true
		if rune2active == true:
			$RuneL2/BlueParticles.emitting = false
			$RuneL2/Blue2Particles.emitting = true
		if rune3active == true:
			$RuneL3/BlueParticles.emitting = false
			$RuneL3/Blue2Particles.emitting = true
		if rune4active == true:
			$RuneL4/BlueParticles.emitting = false
			$RuneL4/Blue2Particles.emitting = true
		if rune5active == true:
			$RuneL5/BlueParticles.emitting = false
			$RuneL5/Blue2Particles.emitting = true
		if rune6active == true:
			$RuneR1/BlueParticles.emitting = false
			$RuneR1/Blue2Particles.emitting = true
		if rune7active == true:
			$RuneR2/BlueParticles.emitting = false
			$RuneR2/Blue2Particles.emitting = true
		if rune8active == true:
			$RuneR3/BlueParticles.emitting = false
			$RuneR3/Blue2Particles.emitting = true
		if rune9active == true:
			$RuneR4/BlueParticles.emitting = false
			$RuneR4/Blue2Particles.emitting = true
		if rune10active == true:
			$RuneR5/BlueParticles.emitting = false
			$RuneR5/Blue2Particles.emitting = true

func _on_AreaL1_body_entered(body):
	if body.name == "Player" and oneshot1:
		oneshot1 = false
		if rune1active == true:
			sfxsound()
			$RuneL1/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "1" or symbol2 == "1":
			explodesound()
			$RuneL1/DestroyParticles.emitting = true
			$RuneL1.texture = null
			if symbol1 == "1":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "1":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneL1/WrongParticles.emitting = true
			wrong+=1

func _on_AreaL2_body_entered(body):
	if body.name == "Player" and oneshot2:
		oneshot2 = false
		if rune2active == true:
			sfxsound()
			$RuneL2/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "2" or symbol2 == "2":
			explodesound()
			$RuneL2/DestroyParticles.emitting = true
			$RuneL2.texture = null
			if symbol1 == "2":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "2":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneL2/WrongParticles.emitting = true
			wrong+=1

func _on_AreaL3_body_entered(body):
	if body.name == "Player" and oneshot3:
		oneshot3 = false
		if rune3active == true:
			sfxsound()
			$RuneL3/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "3" or symbol2 == "3":
			explodesound()
			$RuneL3/DestroyParticles.emitting = true
			$RuneL3.texture = null
			if symbol1 == "3":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "3":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneL3/WrongParticles.emitting = true
			wrong+=1

func _on_AreaL4_body_entered(body):
	if body.name == "Player" and oneshot4:
		oneshot4 = false
		if rune4active == true:
			sfxsound()
			$RuneL4/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "4" or symbol2 == "4":
			explodesound()
			$RuneL4/DestroyParticles.emitting = true
			$RuneL4.texture = null
			if symbol1 == "4":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "4":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneL4/WrongParticles.emitting = true
			wrong+=1

func _on_AreaL5_body_entered(body):
	if body.name == "Player" and oneshot5:
		oneshot5 = false
		if rune5active == true:
			sfxsound()
			$RuneL5/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "5" or symbol2 == "5":
			explodesound()
			$RuneL5/DestroyParticles.emitting = true
			$RuneL5.texture = null
			if symbol1 == "5":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "5":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneL5/WrongParticles.emitting = true
			wrong+=1

func _on_AreaR1_body_entered(body):
	if body.name == "Player" and oneshot6:
		oneshot6 = false
		if rune6active == true:
			sfxsound()
			$RuneR1/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "6" or symbol2 == "6":
			explodesound()
			$RuneR1/DestroyParticles.emitting = true
			$RuneR1.texture = null
			if symbol1 == "6":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "6":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneR1/WrongParticles.emitting = true
			wrong+=1

func _on_AreaR2_body_entered(body):
	if body.name == "Player" and oneshot7:
		oneshot7 = false
		if rune7active == true:
			sfxsound()
			$RuneR2/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "7" or symbol2 == "7":
			explodesound()
			$RuneR2/DestroyParticles.emitting = true
			$RuneR2.texture = null
			if symbol1 == "7":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "7":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneR2/WrongParticles.emitting = true
			wrong+=1

func _on_AreaR3_body_entered(body):
	if body.name == "Player" and oneshot8:
		oneshot8 = false
		if rune8active == true:
			sfxsound()
			$RuneR3/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "8" or symbol2 == "8":
			explodesound()
			$RuneR3/DestroyParticles.emitting = true
			$RuneR3.texture = null
			if symbol1 == "8":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "8":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneR3/WrongParticles.emitting = true
			wrong+=1

func _on_AreaR4_body_entered(body):
	if body.name == "Player" and oneshot9:
		oneshot9 = false
		if rune9active == true:
			sfxsound()
			$RuneR4/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "9" or symbol2 == "9":
			explodesound()
			$RuneR4/DestroyParticles.emitting = true
			$RuneR4.texture = null
			if symbol1 == "9":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "9":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneR4/WrongParticles.emitting = true
			wrong+=1

func _on_AreaR5_body_entered(body):
	if body.name == "Player" and oneshot10:
		oneshot10 = false
		if rune10active == true:
			sfxsound()
			$RuneR5/BlueParticles.emitting = true
			correct+=1
		elif symbol1 == "10" or symbol2 == "10":
			explodesound()
			$RuneR5/DestroyParticles.emitting = true
			$RuneR5.texture = null
			if symbol1 == "10":
				$DestroyRune/DestroyParticles.emitting = true
				$DestroyRune.texture = null
			if symbol2 == "10":
				$DestroyRune2/DestroyParticles.emitting = true
				$DestroyRune2.texture = null
		elif correct >= 6:
			pass
		elif visible == false:
			pass
		else:
			$death.play()
			$RuneR5/WrongParticles.emitting = true
			wrong+=1

var rng = RandomNumberGenerator.new()
var symbol1
var symbol2

var sfxrng
var exprng

func sfxsound():
	sfxrng = rng.randf_range(0,1)
	if sfxrng >= 0.83:
		$runeselect.play()
	elif sfxrng >= 0.67:
		$runeselect2.play()
	elif sfxrng >= 0.50:
		$runeselect3.play()
	elif sfxrng >= 0.33:
		$runeselect4.play()
	elif sfxrng >= 0.16:
		$runeselect5.play()
	elif sfxrng >= 0.0:
		$runeselect6.play()

func explodesound():
	exprng = rng.randf_range(0,1)
	if exprng >= 0.8:
		$explosion1.play()
	elif exprng >= 0.6:
		$explosion2.play()
	elif exprng >= 0.4:
		$explosion3.play()
	elif exprng >= 0.2:
		$explosion4.play()
	elif exprng >= 0.0:
		$explosion5.play()

func _on_HealingParticles_visibility_changed():
	if $".."/Boss/Peppah.state == $".."/Boss/Peppah.HEALING or $".."/Boss/Peppah.state == $".."/Boss/Peppah.RESET:
		if $".."/Boss/Nina.pside == "right":
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
					symbol2 = "10"
		elif $".."/Boss/Nina.pside == "left":
			rng.randomize()
			var rng3 = rng.randf_range(0, 1)
			if rng3 > 0.8:
				symbol1 = "5"
			elif rng3 > 0.6:
				symbol1 = "4"
			elif rng3 > 0.4:
				symbol1 = "3"
			elif rng3 > 0.2:
				symbol1 = "2"
			elif rng3 > 0.0:
				symbol1 = "1"
			rng.randomize()
			var rng4 = rng.randf_range(0, 1)
			if rng4 > 0.8:
				if symbol1 != "5":
					symbol2 = "5"
				else:
					symbol2 = "4"
			elif rng4 > 0.6:
				if symbol1 != "4":
					symbol2 = "4"
				else:
					symbol2 = "3"
			elif rng4 > 0.4:
				if symbol1 != "3":
					symbol2 = "3"
				else:
					symbol2 = "2"
			elif rng4 > 0.2:
				if symbol1 != "2":
					symbol2 = "2"
				else:
					symbol2 = "1"
			elif rng4 > 0.0:
				if symbol1 != "1":
					symbol2 = "1"
				else:
					symbol2 = "5"
		
		var string1 = load("res://assets/sprites/rune0"+str(symbol1)+".png")
		var string2 = load("res://assets/sprites/rune0"+str(symbol2)+".png")
		$DestroyRune.set_texture(string1)
		$DestroyRune2.set_texture(string2)
		$DestroyRune.visible = true
		$DestroyRune2.visible = true
		$DestroyRune.position.x = ($".."/Boss/Nina.position.x - 7)
		$DestroyRune.position.y = ($".."/Boss/Nina.position.y - 20)
		$DestroyRune2.position.x = ($".."/Boss/Nina.position.x + 7)
		$DestroyRune2.position.y = ($".."/Boss/Nina.position.y - 20)
		oneshot1 = true; oneshot2 = true; oneshot3 = true; oneshot4 = true; oneshot5 = true;
		oneshot6 = true; oneshot7 = true; oneshot8 = true; oneshot9 = true; oneshot10 = true;
		rune1active = false; rune2active = false; rune3active = false; rune4active = false; rune5active = false;
		rune6active = false; rune7active = false; rune8active = false; rune9active = false; rune10active = false;
		var string3
		string3 = load("res://assets/sprites/rune01.png")
		$RuneL1.set_texture(string3)
		string3 = load("res://assets/sprites/rune02.png")
		$RuneL2.set_texture(string3)
		string3 = load("res://assets/sprites/rune03.png")
		$RuneL3.set_texture(string3)
		string3 = load("res://assets/sprites/rune04.png")
		$RuneL4.set_texture(string3)
		string3 = load("res://assets/sprites/rune05.png")
		$RuneL5.set_texture(string3)
		string3 = load("res://assets/sprites/rune06.png")
		$RuneR1.set_texture(string3)
		string3 = load("res://assets/sprites/rune07.png")
		$RuneR2.set_texture(string3)
		string3 = load("res://assets/sprites/rune08.png")
		$RuneR3.set_texture(string3)
		string3 = load("res://assets/sprites/rune09.png")
		$RuneR4.set_texture(string3)
		string3 = load("res://assets/sprites/rune010.png")
		$RuneR5.set_texture(string3)
