extends KinematicBody2D

# ATTACKS
var attack
var attackrng = RandomNumberGenerator.new()
var attackrng2

var attack2
var lastattack = 0

const ATTACK1 = preload("res://Scenes/WeebZone/Attack1.tscn")
const ATTACK12 = preload("res://Scenes/WeebZone/Attack12.tscn")
const ATTACK2 = preload("res://Scenes/WeebZone/Attack2.tscn")
const ATTACK22 = preload("res://Scenes/WeebZone/Attack22.tscn")
const ATTACK3 = preload("res://Scenes/WeebZone/Attack3.tscn")
const ATTACK32 = preload("res://Scenes/WeebZone/Attack32.tscn")
const ATTACK4 = preload("res://Scenes/WeebZone/Attack4.tscn")
const ATTACK42 = preload("res://Scenes/WeebZone/Attack42.tscn")
const ATTACK5 = preload("res://Scenes/WeebZone/Attack5.tscn")
const ATTACK52 = preload("res://Scenes/WeebZone/Attack52.tscn")

const RUNEATTACK = preload("res://Scenes/MadmonqRealm/runeattack.tscn")

# COLORS
var colornum = RandomNumberGenerator.new()
var colormod
var colorattack

# TELEPORT
var tpready = false
var positionrand
var oldpositionx = 1000
var oldpositiony = 1000

# ON HIT
var inrange = false
var canbehit = true
var hitrng = RandomNumberGenerator.new()
var sfxrng

# PLAYER STATS
var damage
var pdamage = 1 # PLAYER DAMAGE ADDITION. DEFAULT IS 1. (real time updated by color code)
var playerv = 0

# BOSS STATS
var healthnum = 1000 # HP NUMBER
var healthnum2 = 1000 # PHASE 2 HP NUMBER
var health = healthnum
var killed = false
var oneshotdead = true

# BOSS PHASES
var phase = 1
var phaseoneshot = true

# SHADER
var shadertime = 0;
var shaderparam2 = 0.70;

func _ready():
	$".."/Music/Background1.volume_db = -10
	$".."/Music/Background2.volume_db = -10
	$Timers/StartingTimer.start()

func Attack():
	look_at($".."/Player.position)
	attackrng.randomize()
	attackrng2 = attackrng.randf_range(0,1)
	if attackrng2 >= 0.8:
		if phase == 2:
			attack = ATTACK12.instance()
			lastattack = 12
		else:
			attack = ATTACK1.instance()
	elif attackrng2 >= 0.6:
		if phase == 2:
			attack = ATTACK22.instance()
			lastattack = 22
		else:
			attack = ATTACK2.instance()
	elif attackrng2 >= 0.4:
		if phase == 2:
			attack = ATTACK32.instance()
			lastattack = 32
		else:
			attack = ATTACK3.instance()
	elif attackrng2 >= 0.2:
		if phase == 2:
			attack = ATTACK42.instance()
			lastattack = 42
		else:
			attack = ATTACK4.instance()
	else:
		if phase == 2:
			attack = ATTACK52.instance()
			lastattack = 52
		else:
			attack = ATTACK5.instance()
	attack.transform = transform
	if colormod == "red":
		attack.modulate = Color(255,0,0)
		colorattack = "red"
	if colormod == "green":
		attack.modulate = Color(0,255,0)
		colorattack = "green"
	if colormod == "blue":
		attack.modulate = Color(0,150,255)
		colorattack = "blue"
	if colormod == "purple":
		attack.modulate = Color(255,0,255)
		colorattack = "purple"
	if colormod == "yellow":
		attack.modulate = Color(255,255,0)
		colorattack = "yellow"
	$".."/.add_child(attack)
	if phase == 2 and attack2 == true:
		attack2 = false
		look_at($".."/Player.position)
		if lastattack == 12:
			attack = ATTACK52.instance()
		if lastattack == 22:
			attack = ATTACK32.instance()
		if lastattack == 32:
			attack = ATTACK42.instance()
		if lastattack == 42:
			attack = ATTACK12.instance()
		if lastattack == 52:
			attack = ATTACK22.instance()
		colornum = randf()
		if colornum >= 0.8:
			colormod = "red"
			if colorattack == "red":
				colormod = "green"
		elif colornum >= 0.6:
			colormod = "green"
			if colorattack == "green":
				colormod = "blue"
		elif colornum >= 0.4:
			colormod = "blue"
			if colorattack == "blue":
				colormod = "purple"
		elif colornum >= 0.2:
			colormod = "purple"
			if colorattack == "purple":
				colormod = "yellow"
		else:
			colormod = "yellow"
			if colorattack == "yellow":
				colormod = "red"
		attack.transform = transform
		if colormod == "red":
			attack.modulate = Color(255,0,0)
		if colormod == "green":
			attack.modulate = Color(0,255,0)
		if colormod == "blue":
			attack.modulate = Color(0,150,255)
		if colormod == "purple":
			attack.modulate = Color(255,0,255)
		if colormod == "yellow":
			attack.modulate = Color(255,255,0)
		$".."/.add_child(attack)

func finalattack():
	look_at($".."/Player.position)
	attack = ATTACK1.instance()
	colormod = "red"
	attack.modulate = Color(255,0,0)
	attack.transform = transform
	$".."/.add_child(attack)
	#attack = ATTACK12.instance()
	#colormod = "green"
	#attack.modulate = Color(0,255,0)
	#attack.transform = transform
	#$".."/.add_child(attack)
	attack = ATTACK2.instance()
	colormod = "blue"
	attack.modulate = Color(0,150,255)
	attack.transform = transform
	$".."/.add_child(attack)
	#attack = ATTACK22.instance()
	#colormod = "purple"
	#attack.modulate = Color(255,0,255)
	#attack.transform = transform
	#$".."/.add_child(attack)
	attack = ATTACK3.instance()
	colormod = "yellow"
	attack.modulate = Color(255,255,0)
	attack.transform = transform
	$".."/.add_child(attack)
	#attack = ATTACK32.instance()
	#colormod = "red"
	#attack.modulate = Color(255,0,0)
	#attack.transform = transform
	#$".."/.add_child(attack)
	attack = ATTACK4.instance()
	colormod = "green"
	attack.modulate = Color(0,255,0)
	attack.transform = transform
	$".."/.add_child(attack)
	#attack = ATTACK42.instance()
	#colormod = "blue"
	#attack.modulate = Color(0,150,255)
	#attack.transform = transform
	#$".."/.add_child(attack)
	attack = ATTACK5.instance()
	colormod = "purple"
	attack.modulate = Color(255,0,255)
	attack.transform = transform
	$".."/.add_child(attack)
	#attack = ATTACK52.instance()
	#colormod = "yellow"
	#attack.modulate = Color(255,255,0)
	#attack.transform = transform
	#$".."/.add_child(attack)

func runeattack():
	look_at($".."/Player.position)
	attack = RUNEATTACK.instance()
	colornum = randf()
	if colornum >= 0.8:
		colormod = "red"
		if colorattack == "red":
			colormod = "green"
	elif colornum >= 0.6:
		colormod = "green"
		if colorattack == "green":
			colormod = "blue"
	elif colornum >= 0.4:
		colormod = "blue"
		if colorattack == "blue":
			colormod = "purple"
	elif colornum >= 0.2:
		colormod = "purple"
		if colorattack == "purple":
			colormod = "yellow"
	else:
		colormod = "yellow"
		if colorattack == "yellow":
			colormod = "red"
	attack.transform = transform
	if colormod == "red":
		attack.modulate = Color(255,0,0)
	if colormod == "green":
		attack.modulate = Color(0,255,0)
	if colormod == "blue":
		attack.modulate = Color(0,150,255)
	if colormod == "purple":
		attack.modulate = Color(255,0,255)
	if colormod == "yellow":
		attack.modulate = Color(255,255,0)
	$".."/.add_child(attack)

func Teleport():
	$tp/tpparticles.emitting = false
	
	if phase == 3:
		rotation = 0
		position.x = 240
		position.y = 90
	else:
		$".."/Runes.spawnrune()
		# x = 60 to 420
		# y = 140 to 190
		position.y = rand_range(140,190)
		if $".."/Player.position.x > 240:
			positionrand = rand_range(60,200)
		else:
			positionrand = rand_range(280,420)
		if oldpositionx == 240 and oldpositiony == 100:
			if $".."/Player.position.x > 240:
				position.x = 80
				position.y = 170
			else:
				position.x = 400
				position.y = 170
		elif (oldpositionx - positionrand <= abs(25)) and (oldpositiony - oldpositiony <= abs(25)):
			position.x = 240
			position.y = 100
		else:
			position.x = positionrand
		oldpositionx = position.x
		oldpositiony = position.y

func _physics_process(delta):
# SHADER TIME
	shadertime += delta/10
	$".."/Background/ColorRect.material.set("shader_param/time",shadertime)
	shaderparam2 += delta/500
	$".."/Background/ColorRect.material.set("shader_param/formuparam2",shaderparam2)
	
# ROTATION FUN!
	$Sprite.rotate(delta*(2-(health/1000)))

# ATTACK COLOR + RNG
	if tpready == true:
		colornum = randf()
		if colornum >= 0.8:
			colormod = "red"
		elif colornum >= 0.6:
			colormod = "green"
		elif colornum >= 0.4:
			colormod = "blue"
		elif colornum >= 0.2:
			colormod = "purple"
		else:
			colormod = "yellow"
# TELEPORT
	if $tp/tpparticles.emitting == true:
		modulate.a -= delta*1.25
	else:
		modulate.a = 1
	if health>=(healthnum*7/8) and phase == 1:
		$tp/tptimer.wait_time = 5.25
		$tp/tpparticletimer.wait_time = 4.5
	elif health>=(healthnum*6/8) and phase == 1:
		$tp/tptimer.wait_time = 5
		$tp/tpparticletimer.wait_time = 4.0
	elif health>=(healthnum*5/8) and phase == 1:
		$tp/tptimer.wait_time = 4.75
		$tp/tpparticletimer.wait_time = 3.75
	elif health>=(healthnum*4/8) and phase == 1:
		$tp/tptimer.wait_time = 4.5
		$tp/tpparticletimer.wait_time = 3.5
	elif health>=(healthnum*3/8) and phase == 1:
		$tp/tptimer.wait_time = 4.25
		$tp/tpparticletimer.wait_time = 3.25
	elif health>=(healthnum*2/8) and phase == 1:
		$tp/tptimer.wait_time = 4.0
		$tp/tpparticletimer.wait_time = 3.0
	elif health>=(healthnum*1/8) and phase == 1:
		$tp/tptimer.wait_time = 3.75
		$tp/tpparticletimer.wait_time = 2.75
	elif health>=(healthnum*0/8) and phase == 1:
		$tp/tptimer.wait_time = 3.5
		$tp/tpparticletimer.wait_time = 2.5
	elif health>=(healthnum2*7/8) and phase == 2:
		$tp/tptimer.wait_time = 5.25
		$tp/tpparticletimer.wait_time = 4.25
	elif health>=(healthnum2*6/8) and phase == 2:
		$tp/tptimer.wait_time = 5
		$tp/tpparticletimer.wait_time = 4.0
	elif health>=(healthnum2*5/8) and phase == 2:
		$tp/tptimer.wait_time = 4.75
		$tp/tpparticletimer.wait_time = 3.75
	elif health>=(healthnum2*4/8) and phase == 2:
		$tp/tptimer.wait_time = 4.5
		$tp/tpparticletimer.wait_time = 3.5
	elif health>=(healthnum2*3/8) and phase == 2:
		$tp/tptimer.wait_time = 4.25
		$tp/tpparticletimer.wait_time = 3.25
	elif health>=(healthnum2*2/8) and phase == 2:
		$tp/tptimer.wait_time = 4.0
		$tp/tpparticletimer.wait_time = 3.0
	elif health>=(healthnum2*1/8) and phase == 2:
		$tp/tptimer.wait_time = 3.75
		$tp/tpparticletimer.wait_time = 2.75
	elif health>=(healthnum2*0/8) and phase == 2:
		$tp/tptimer.wait_time = 3.5
		$tp/tpparticletimer.wait_time = 2.5
	if tpready == true and (phase == 1 or phase == 2):
		tpready = false
		Teleport()
		Attack()
		$tp/tptimer.start()
		$tp/tpparticletimer.start()
	elif tpready == true and phase == 3:
		tpready = false
		Teleport()

# ON HIT
	if inrange == true and canbehit == true:
		if $".."/Player/MEGA.emitting == true:
			buffhitreset()
		if $".."/Player.state == $".."/Player.TJUMPING:
			
			$".."/Player.state = $".."/Player.FALLING
			$".."/Player.velocity.y = -40
			$".."/Player.velocity.x = $".."/Player.triplev*-100
			
			hitrng.randomize()
			sfxrng = hitrng.randf_range(0, 1)
			if sfxrng >= 0.8:
				$SFX/AudioStreamPlayer2D.play()
			elif sfxrng >= 0.6:
				$SFX/AudioStreamPlayer2D2.play()
			elif sfxrng >= 0.4:
				$SFX/AudioStreamPlayer2D3.play()
			elif sfxrng >= 0.2:
				$SFX/AudioStreamPlayer2D4.play()
			elif sfxrng >= 0.0:
				$SFX/AudioStreamPlayer2D5.play()
			canbehit = false
			inrange = false
			damage = clamp($".."/Player.velocity.x/2, 50, 100)
			health -= damage*pdamage
			$".."/CanvasLayer/HP/ProgressBar.value = health
			$Timers/HitTimer.start()
			$Sprite.self_modulate = Color8(255,100,100,255)
		elif $".."/Player.state == $".."/Player.DJUMPING:
			
			if $".."/Player/PlayerSprite.animation.begins_with("walkright"):
				playerv = -50
			else:
				playerv = 50
			$".."/Player.state = $".."/Player.FALLING
			$".."/Player.velocity.y = -60
			$".."/Player.velocity.x = playerv
			
			hitrng.randomize()
			sfxrng = hitrng.randf_range(0, 1)
			if sfxrng >= 0.8:
				$SFX/AudioStreamPlayer2D.play()
			elif sfxrng >= 0.6:
				$SFX/AudioStreamPlayer2D2.play()
			elif sfxrng >= 0.4:
				$SFX/AudioStreamPlayer2D3.play()
			elif sfxrng >= 0.2:
				$SFX/AudioStreamPlayer2D4.play()
			elif sfxrng >= 0.0:
				$SFX/AudioStreamPlayer2D5.play()
			canbehit = false
			inrange = false
			damage = clamp($".."/Player.velocity.x/2, 25, 50)
			health -= damage*pdamage
			$".."/CanvasLayer/HP/ProgressBar.value = health
			$Timers/HitTimer.start()
			$Sprite.self_modulate = Color8(255,100,100,255)
		else:
			if $".."/Player/PlayerSprite.animation.begins_with("walkright"):
				playerv = -30
			else:
				playerv = 30
			$".."/Player.state = $".."/Player.FALLING
			$".."/Player.velocity.y = -40
			$".."/Player.velocity.x = playerv
			
			hitrng.randomize()
			sfxrng = hitrng.randf_range(0, 1)
			if sfxrng >= 0.8:
				$SFX/AudioStreamPlayer2D.play()
			elif sfxrng >= 0.6:
				$SFX/AudioStreamPlayer2D2.play()
			elif sfxrng >= 0.4:
				$SFX/AudioStreamPlayer2D3.play()
			elif sfxrng >= 0.2:
				$SFX/AudioStreamPlayer2D4.play()
			elif sfxrng >= 0.0:
				$SFX/AudioStreamPlayer2D5.play()
			canbehit = false
			inrange = false
			damage = clamp($".."/Player.velocity.x/2, 10, 30)
			health -= damage*pdamage
			$".."/CanvasLayer/HP/ProgressBar.value = health
			$Timers/HitTimer.start()
			$Sprite.self_modulate = Color8(255,100,100,255)

# DEATH
	if health <= 0 and oneshotdead == true and phase == 3:
		oneshotdead = false
		$Sprite.visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$KillParticles.emitting = true
		
		$".."/Music/Background1.volume_db = -80
		$".."/Music/Background2.volume_db = -80
		$".."/Music/Background1.stop()
		$".."/Music/Background2.stop()
		$".."/Music/EndMusic.play()
		
		$Timers/EndscreenTimer.start()

# DURING BUFF STUN
	if $stunshield.visible == true:
		$stunshield.modulate.a -= delta/5

# PHASES
	if health <= 0 and phaseoneshot == true:
		phaseoneshot = false
		$".."/Player/MEGA.emitting = false
		$tp/tptimer.stop()
		$tp/tpparticletimer.stop()
		$tp/tpparticles.emitting = false
		$stuntimer.stop()
		$stunshield.visible = false
		oldpositionx = 1000
		oldpositiony = 1000
		lastattack = 0
		
		if phase == 1:
			$Phase2Timer.start()
			
			$KillParticles.emitting = true
			$CollisionShape2D.set_deferred("disabled", true)
			$Area2D/CollisionShape2D.set_deferred("disabled", true)
			
		if phase == 2:
			health = healthnum2
			pdamage = -1000
			$".."/CanvasLayer/HP/ProgressBar.value = healthnum2
			$".."/CanvasLayer/HP/ProgressBar.max_value = healthnum2*100
			$tp/tptimer.start(0.76)
			$tp/tpparticletimer.start(0.01)
			phase = 3
			$finalnoisetimer.start()
			$finaltimer.start()
	
	if phase == 1 and health <= 0:
		$Sprite.modulate.a -= delta/3
		$".."/Runes.modulate.a -= delta/3
		if $Sprite.modulate.a < -3:
			position.x = 240
			position.y = 90
			rotation = 0
	if phase == 2 and phaseoneshot == false:
		$Sprite.modulate.a += delta/2
		if $Sprite.modulate.a > 1:
			$Sprite.modulate.a = 1
		$Phase2Particles.emitting = true
		$Phase2Particles.modulate.a += delta/3
		if $Phase2Particles.modulate.a > 1:
				$Phase2Particles.modulate.a = 1
		health += delta*250
		$".."/CanvasLayer/HP/ProgressBar.value = health
		if health >= healthnum2:
			health = healthnum2
			$".."/CanvasLayer/HP/ProgressBar.max_value = healthnum2
			phaseoneshot = true
			$Phase2Particles.emitting = false
			$Sprite.modulate.a = 1
			$tp/tptimer.start(1.75)
			$tp/tpparticletimer.start(1)
			$".."/Runes.reset_symbols()
			$".."/Runes.reset()
			
	if phase == 3:
		$".."/Runes.modulate.a -= delta
		$".."/Music/Background1.volume_db -= delta*2
		$".."/Music/Background2.volume_db -= delta*2

func buffhitreset():
	$".."/Player/MEGA.emitting = false
	$tp/tptimer.stop()
	$tp/tpparticletimer.stop()
	$tp/tpparticles.emitting = false
	
	oldpositionx = 1000
	oldpositiony = 1000
	lastattack = 0
	
	$".."/CanvasLayer/HP/ProgressBar.value = health
	
	$stunshield.modulate.a = 1
	$stunshield.visible = true
	
	$stuntimer.start()

func _on_Area2D_body_entered(body):
	if killed == true:
			pass
	elif body.name == "Player":
		inrange = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		inrange = false

func _on_HitTimer_timeout():
	if killed == true:
		pass
	else:
		canbehit = true
		$Sprite.self_modulate = Color8(255,255,255,255)

func _on_StartingTimer_timeout():
	$tp/tptimer.start(0.76)
	$tp/tpparticletimer.start(0.01)

func _on_EndscreenTimer_timeout():
	$".."/Endscreen/Control.visible = true

func _on_tptimer_timeout():
	tpready = true
	if phase == 3:
		pass
	else:
		attack2 = true

func _on_tpparticletimer_timeout():
	if $stunshield.visible == true:
		pass
	else:
		$tp/tpparticles.emitting = true
		$tp/tpnoise.play()

func _on_stuntimer_timeout():
	if health <= 0:
		pass
	else:
		$tp/tptimer.start(0.76)
		$tp/tpparticletimer.start(0.01)
		$".."/Runes.reset()
		$stunshield.visible = false

func _on_Phase2Timer_timeout():
	phase = 2
	$CollisionShape2D.set_deferred("disabled", false)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	position.x = 240
	position.y = 90
	rotation = 0
	$Sprite.modulate.a = 0
	$".."/Runes.reset()

func _on_finalnoisetimer_timeout():
	$finalstand.play()

func _on_finaltimer_timeout():
	finalattack()
	$unluckytimer.start()

func _on_unluckytimer_timeout():
	$deathtimer.start()

func _on_deathtimer_timeout():
	$explosion.visible = true
	$explosion.play()
	$explosionaudio.play()
	health = 0
	$".."/CanvasLayer/HP/ProgressBar.value = health
	$Sprite2.queue_free()
	$Sprite3.queue_free()
	$Sprite4.queue_free()
	$Sprite5.queue_free()
	
	$".."/Player.position.x = 240
	$".."/Player.position.y = 210.5
	$".."/Player.rotation = 0
	$".."/Player/AnimationPlayer.play("WinSequence")
	$".."/Player.state = $".."/Player.END
