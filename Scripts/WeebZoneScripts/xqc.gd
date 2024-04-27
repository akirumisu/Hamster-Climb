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

# COLORS
var colornum = RandomNumberGenerator.new()
var colormod
var colorattack

# TELEPORT
var tpready = false
var positionrand
var tpalpha = 1

# ON HIT
var inrange = false
var canbehit = true
var hitrng = RandomNumberGenerator.new()
var sfxrng

# PLAYER STATS
var damage
var pdamage = 1
var playerv = 0

# BOSS STATS
const c_health = 1500 #1500
const c_health2 = 750 #750
var health = c_health
var killed = false
var oneshotdead = true

# TILES VARIABLES
var tilestoofar = false

# SCREAM
var oneshothalf = true

func _ready():
	$StartingTimer.start()

func Attack():
	
	$Sprite.modulate.a = 1
	
	look_at($".."/Player.position)
	attackrng.randomize()
	attackrng2 = attackrng.randf_range(0,1)
	if attackrng2 >= 0.8:
		$SunAttack1.play()
		if health <= c_health2:
			attack = ATTACK12.instance()
			lastattack = 12
		else:
			attack = ATTACK1.instance()
	elif attackrng2 >= 0.6:
		$SunAttack2.play()
		if health <= c_health2:
			attack = ATTACK22.instance()
			lastattack = 22
		else:
			attack = ATTACK2.instance()
	elif attackrng2 >= 0.4:
		$SunAttack3.play()
		if health <= c_health2:
			attack = ATTACK32.instance()
			lastattack = 32
		else:
			attack = ATTACK3.instance()
	elif attackrng2 >= 0.2:
		$SunAttack4.play()
		if health <= c_health2:
			attack = ATTACK42.instance()
			lastattack = 42
		else:
			attack = ATTACK4.instance()
	else:
		$SunAttack5.play()
		if health <= c_health2:
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
	if health <= c_health2 and attack2 == true:
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

func Teleport():
	position.y = $".."/Player.position.y-rand_range(100,150)
	if $".."/Player.position.x > 200 and $".."/Player.position.x < 300:
		attackrng.randomize()
		positionrand = attackrng.randf_range(0,1)
		if positionrand >= 0.5:
			position.x = 400
		else:
			position.x = 80
	else:
		if $".."/Player.position.x > 300:
			position.x = 480-$".."/Player.position.x+rand_range(25,50)
		if $".."/Player.position.x < 200:
			position.x = 480-$".."/Player.position.x+rand_range(-25,-50)

func _physics_process(delta):	
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
	if health>=float(c_health)*9/10:
		$tp/tptimer.wait_time = 8
		$tp/tpparticletimer.wait_time = 7.25
	elif health>=float(c_health)*8/10:
		$tp/tptimer.wait_time = 7.75
		$tp/tpparticletimer.wait_time = 7.00
	elif health>=float(c_health)*7/10:
		$tp/tptimer.wait_time = 7.5
		$tp/tpparticletimer.wait_time = 6.75
	elif health>=float(c_health)*6/10:
		$tp/tptimer.wait_time = 7.25
		$tp/tpparticletimer.wait_time = 6.50
	elif health>=float(c_health)*5/10:
		$tp/tptimer.wait_time = 7
		$tp/tpparticletimer.wait_time = 6.25
	elif health>=float(c_health)*4/10:
		$tp/tptimer.wait_time = 6.75
		$tp/tpparticletimer.wait_time = 6
	elif health>=float(c_health)*3/10:
		$tp/tptimer.wait_time = 6.5
		$tp/tpparticletimer.wait_time = 5.75
	elif health>=float(c_health)*2/10:
		$tp/tptimer.wait_time = 6.25
		$tp/tpparticletimer.wait_time = 5.50
	elif health>=float(c_health)*1/10:
		$tp/tptimer.wait_time = 6
		$tp/tpparticletimer.wait_time = 5.25
	elif health>=float(c_health)*0/10:
		$tp/tptimer.wait_time = 5.75
		$tp/tpparticletimer.wait_time = 5.00
	if tpready == true:
		tpready = false
		Teleport()
		Attack()
		$tp/tptimer.start()
		$tp/tpparticletimer.start()
	if tpalpha == 0:
		$Sprite.modulate.a -= delta*1.25
# ON HIT
	if inrange == true and canbehit == true:
		if $".."/Player.state == $".."/Player.TJUMPING:
			
			$FallTimer.start()
			
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
			$HitTimer.start()
			$Sprite.self_modulate = Color8(255,100,100,255)
		elif $".."/Player.state == $".."/Player.DJUMPING:
			
			$FallTimer.start()
			
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
			$HitTimer.start()
			$Sprite.self_modulate = Color8(255,100,100,255)
		else:
			
			$FallTimer.start()
			
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
			$HitTimer.start()
			$Sprite.self_modulate = Color8(255,100,100,255)
# SCREAM
	if health <= c_health2 and oneshothalf == true:
		oneshothalf = false
		$AudioStreamPlayer2D.play()
		$halfparticles.emitting = true
# TILES MOVING
	if health > 0:
		if $".."/MovingTiles.position.x >= 900:
			tilestoofar = true
		if $".."/MovingTiles.position.x <= 600:
			tilestoofar = false
			
		if tilestoofar == true:
			$".."/MovingTiles.position.x -= delta*50
		elif tilestoofar == false:
			$".."/MovingTiles.position.x += delta*50
# BOG MOVING
	if health > 0:
		if health >= float(c_health)*2/3 and (abs($".."/Player.position.y) - abs($".."/Bog.position.y)) >= -25:
			$".."/Bog.position.y -= delta*500
		elif health >= float(c_health)*1/3 and (abs($".."/Player.position.y) - abs($".."/Bog.position.y)) >= -50:
			$".."/Bog.position.y -= delta*500
		elif health >= float(c_health)*0/3 and (abs($".."/Player.position.y) - abs($".."/Bog.position.y)) >= -75:
			$".."/Bog.position.y -= delta*500
		else:
			if health >= float(c_health)*3/4:
				$".."/Bog.position.y -= delta*10
			elif health >= float(c_health)*2/4:
				$".."/Bog.position.y -= delta*15
			elif health >= float(c_health)*1/4:
				$".."/Bog.position.y -= delta*20
			elif health >= float(c_health)*0/4:
				$".."/Bog.position.y -= delta*25
# DEATH
	if health <= 0 and oneshotdead == true:
		oneshotdead = false
		$explosion.visible = true
		$explosion.play()
		$explosionaudio.play()
		
		$".."/Player.rotation = 0
		$".."/Player/AnimationPlayer.play("WinSequence")
		$".."/Player.state = $".."/Player.END
		
		$tp/tptimer.stop()
		$tp/tpparticletimer.stop()
		$KillParticles.emitting = true
		$Sprite.visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$".."/Music/Background1.volume_db = -80
		$".."/Music/Background2.volume_db = -80
		$".."/Music/Background1.stop()
		$".."/Music/Background2.stop()
		$".."/Music/EndMusic.play()
		$EndscreenTimer.start()

func _on_tptimer_timeout():
	tpalpha = 1
	attack2 = true
	tpready = true

func _on_tpparticletimer_timeout():
	tpalpha = 0
	$tp/tpparticles.emitting = true
	$tp/tpnoise.play()

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

func _on_BogArea2D_body_entered(body):
	if body.name == "Player" and health > 0:
		$".."/Player.state = $".."/Player.DEATH

func _on_StartingTimer_timeout():
	attack2 = true
	tpready = true
	$tp/tpnoise.play()

func _on_FallTimer_timeout():
	if $".."/Player.state == $".."/Player.FALLING:
		$".."/Player.state = $".."/Player.ONGROUND

func _on_EndscreenTimer_timeout():
	$".."/Endscreen/Control.visible = true
	$".."/Player.position.y = 1000
