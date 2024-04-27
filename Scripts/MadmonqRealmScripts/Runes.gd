extends Node2D

var rune10active; var rune9active; var rune8active; var rune7active; var rune6active;
var rune5active; var rune4active; var rune3active; var rune2active; var rune1active

var oneshot1 = true; var oneshot2 = true; var oneshot3 = true; var oneshot4 = true; var oneshot5 = true;
var oneshot6 = true; var oneshot7 = true; var oneshot8 = true; var oneshot9 = true; var oneshot10 = true;
var timeroneshot

var symbol1 = "0"; var symbol2 = "0"; var symbol3 = "0"; var symbol4 = "0"; var symbol5 = "0"
var symbol6 = "0"; var symbol7 = "0"; var symbol8 = "0"; var symbol9 = "0"; var symbol10 = "0"

var runecount = 0

var correct = 0
var wrong = 0
var correctoneshot = true

var rng = RandomNumberGenerator.new()

var runenumber

var oldrune1
var oldrune2
var oldrune3

var runeready = false

var fadeout

var modulateincreasing

func _ready():
	reset_symbols()

func reset_symbols(): # Set Randomized Symbols
	var arr = get_random_numbers(1,11)
	symbol1 = str(arr[0])
	symbol2 = str(arr[1])
	symbol3 = str(arr[2])
	symbol4 = str(arr[3])
	symbol5 = str(arr[4])
	symbol6 = str(arr[5])
	symbol7 = str(arr[6])
	symbol8 = str(arr[7])
	symbol9 = str(arr[8])
	symbol10 = str(arr[9])
	for i in range(0,9):
		var string = load("res://assets/sprites/rune0"+str(arr[i])+".png")
		if i == 0:
			$RuneL1.set_texture(string)
		if i == 1:
			$RuneL2.set_texture(string)
		if i == 2:
			$RuneL3.set_texture(string)
		if i == 3:
			$RuneL4.set_texture(string)
		if i == 4:
			$RuneL5.set_texture(string)
		if i == 5:
			$RuneR1.set_texture(string)
		if i == 6:
			$RuneR2.set_texture(string)
		if i == 7:
			$RuneR3.set_texture(string)
		if i == 8:
			$RuneR4.set_texture(string)
		else:
			string = load("res://assets/sprites/rune0"+str(arr[9])+".png")
			$RuneR5.set_texture(string)

func get_random_numbers(from, to): # Random Order Generator
	var arr = []
	for i in range(from,to):
		arr.append(i)
	arr.shuffle()
	return arr

func spawnrune():
	if (runecount < 3 and $".."/Forsen.phase == 1) or ($".."/Forsen.phase == 2 and runecount < 5):
		rng.randomize()
		runenumber = rng.randi_range(1,10)
		while runenumber == oldrune1 or runenumber == oldrune2 or runenumber == oldrune3:
			runenumber = rng.randi_range(1,10)
		
		runecount += 1
		if runecount == 1:
			oldrune1 = runenumber
		if runecount == 2:
			oldrune2 = runenumber
		if runecount == 3:
			oldrune3 = runenumber
		
		$".."/ForsenRune.position = $".."/Forsen.position
		
		var string = load("res://assets/sprites/rune0"+str(runenumber)+".png")
		$".."/ForsenRune.set_texture(string)
		$".."/ForsenRune.visible = true
		
		if $".."/Forsen.phase == 1:
			$".."/ForsenRune/FadeOut.wait_time = 2
		else:
			$".."/ForsenRune/FadeOut.wait_time = 1
		$".."/ForsenRune/FadeOut.start()
		$".."/ForsenRune/Particles2D.emitting = true
		
		$".."/ForsenRune.modulate.a = 1
		fadeout = false
		
		runeready = true
	else:
		$".."/Forsen.runeattack()

func allcorrect():
	$buffsound.play()
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

func _process(delta):
	
	if fadeout == true:
		$".."/ForsenRune.modulate.a -= delta
		$".."/ForsenRune/Particles2D.emitting = false
	
	if runeready == true:
		for i in range (1,11):
			if runenumber == i:
				if symbol1 == str(i):
					rune1active = true
				elif symbol2 == str(i):
					rune2active = true
				elif symbol3 == str(i):
					rune3active = true
				elif symbol4 == str(i):
					rune4active = true
				elif symbol5 == str(i):
					rune5active = true
				elif symbol6 == str(i):
					rune6active = true
				elif symbol7 == str(i):
					rune7active = true
				elif symbol8 == str(i):
					rune8active = true
				elif symbol9 == str(i):
					rune9active = true
				elif symbol10 == str(i):
					rune10active = true
				runeready = false
	
	if $".."/Forsen.phase == 1 and correct >= 3:
		if correctoneshot == true:
			allcorrect()
			correctoneshot = false
		modulate.a -= delta
		if modulate.a <= 0:
			visible = false
	elif $".."/Forsen.phase == 2 and correct >= 5:
		if correctoneshot == true:
			allcorrect()
			correctoneshot = false
		modulate.a -= delta
		if modulate.a <= 0:
			visible = false
	
	if wrong == 1:
		$".."/Player/color.red += 1
		wrong = 0
	
	if modulateincreasing == true:
		modulate.a += delta
		if modulate.a >= 1:
			modulate.a = 1
			modulateincreasing = false

func _on_AreaL1_body_entered(body):
	if body.name == "Player" and oneshot1:
		oneshot1 = false
		if rune1active == true:
			sfxsound()
			$RuneL1/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneL1/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 1
			wrong+=1

func _on_AreaL2_body_entered(body):
	if body.name == "Player" and oneshot2:
		oneshot2 = false
		if rune2active == true:
			sfxsound()
			$RuneL2/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneL2/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 2
			wrong+=1

func _on_AreaL3_body_entered(body):
	if body.name == "Player" and oneshot3:
		oneshot3 = false
		if rune3active == true:
			sfxsound()
			$RuneL3/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneL3/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 3
			wrong+=1

func _on_AreaL4_body_entered(body):
	if body.name == "Player" and oneshot4:
		oneshot4 = false
		if rune4active == true:
			sfxsound()
			$RuneL4/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneL4/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 4
			wrong+=1

func _on_AreaL5_body_entered(body):
	if body.name == "Player" and oneshot5:
		oneshot5 = false
		if rune5active == true:
			sfxsound()
			$RuneL5/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneL5/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 5
			wrong+=1

func _on_AreaR1_body_entered(body):
	if body.name == "Player" and oneshot6:
		oneshot6 = false
		if rune6active == true:
			sfxsound()
			$RuneR1/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneR1/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 6
			wrong+=1

func _on_AreaR2_body_entered(body):
	if body.name == "Player" and oneshot7:
		oneshot7 = false
		if rune7active == true:
			sfxsound()
			$RuneR2/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneR2/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 7
			wrong+=1

func _on_AreaR3_body_entered(body):
	if body.name == "Player" and oneshot8:
		oneshot8 = false
		if rune8active == true:
			sfxsound()
			$RuneR3/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneR3/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 8
			wrong+=1

func _on_AreaR4_body_entered(body):
	if body.name == "Player" and oneshot9:
		oneshot9 = false
		if rune9active == true:
			sfxsound()
			$RuneR4/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneR4/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 9
			wrong+=1

func _on_AreaR5_body_entered(body):
	if body.name == "Player" and oneshot10:
		oneshot10 = false
		if rune10active == true:
			sfxsound()
			$RuneR5/BlueParticles.emitting = true
			correct+=1
		elif correct >= 6:
			pass
		elif modulate.a < 1 or visible == false:
			pass
		else:
			$death.play()
			$RuneR5/WrongParticles.emitting = true
			$Timer.start()
			timeroneshot = 10
			wrong+=1

var sfxrng

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

func reset(): # ON RESET
	oneshot1 = true; oneshot2 = true; oneshot3 = true; oneshot4 = true; oneshot5 = true;
	oneshot6 = true; oneshot7 = true; oneshot8 = true; oneshot9 = true; oneshot10 = true;
	rune1active = false; rune2active = false; rune3active = false; rune4active = false; rune5active = false;
	rune6active = false; rune7active = false; rune8active = false; rune9active = false; rune10active = false;
	$RuneR1/BlueParticles.emitting = false; $RuneR2/BlueParticles.emitting = false; $RuneR3/BlueParticles.emitting = false;
	$RuneR4/BlueParticles.emitting = false; $RuneR5/BlueParticles.emitting = false; $RuneL1/BlueParticles.emitting = false;
	$RuneL2/BlueParticles.emitting = false; $RuneL3/BlueParticles.emitting = false; $RuneL4/BlueParticles.emitting = false;
	$RuneL5/BlueParticles.emitting = false;
	
	oldrune1 = 11; oldrune2 = 11; oldrune3 = 11
	
	runecount = 0
	
	correct = 0
	correctoneshot = true
	
	modulate.a = 0
	modulateincreasing = true
	visible = true

func _on_FadeOut_timeout():
	fadeout = true

func _on_Timer_timeout():
	if timeroneshot == 1:
		oneshot1 = true
	if timeroneshot == 2:
		oneshot2 = true
	if timeroneshot == 3:
		oneshot3 = true
	if timeroneshot == 4:
		oneshot4 = true
	if timeroneshot == 5:
		oneshot5 = true
	if timeroneshot == 6:
		oneshot6 = true
	if timeroneshot == 7:
		oneshot7 = true
	if timeroneshot == 8:
		oneshot8 = true
	if timeroneshot == 9:
		oneshot9 = true
	if timeroneshot == 10:
		oneshot10 = true
