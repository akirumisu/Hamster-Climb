extends KinematicBody2D

var dashrng
var cooldown = 0
var oneshot = 0

var SPEED = 50
var slidex
var slidey
var rotatespeed

var state = INTRO
const INTRO = 0; const PREDICT = 1; const FLYING = 2; const CHARGING = 3; const HEALING = 4;
const FINALSTAND = 5; const DEAD = 6; const CHARGING2 = 7; const RESET = 8;

var damage = 0
var health = 2300 #2300
var canbehit = true

var audiooneshot = true

var oneshotflying = true

var oneshothealing = true
var oneshotrune1 = true
var oneshotrune2 = true

var laughingoneshot = true
var seboneshot = true

var timeleft = 7

var pside = "left"

var killed = false

var i = 0.0

var timeleftpeppah

var hitrng = RandomNumberGenerator.new()
var sfxrng

var inrange = false

var playerv = 0

const BULLET = preload("res://Scenes/Asylum/Bullet.tscn")
func shoot():
	look_at($".."/".."/Player.position)
	#rotate(-PI/2)
	var bullet = BULLET.instance()
	bullet.transform = transform
	$".."/"..".add_child(bullet)

func _physics_process(_delta):
	if state == PREDICT:
		if audiooneshot == true:
			audiooneshot = false
			$AudioStreamPlayer.play()
		canbehit = true
		oneshothealing = true
		if dashrng == 0 and cooldown == 0:
			$RPeppah.emitting = true
			cooldown = 1
		if dashrng == 1 and cooldown == 0:
			$LPeppah.emitting = true
			cooldown = 1
	
	if state == FLYING:
		audiooneshot = true
		if cooldown == 0:
			shoot()
			rotatespeed = (randf()-0.5)/SPEED
			slidex = (randf()-0.5)*SPEED
			slidey = -(rotation)*SPEED/2
			cooldown = 1
		if slidex:
			rotate(rotatespeed)
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(slidex,slidey),Vector2(0,1))
			if position.y > 110:
				slidey = -SPEED/2
				rotation = 0
			if position.y < 37:
				slidey = SPEED/2
				rotation = 0
		if oneshotflying == true:
			oneshotflying = false
			$TooLongTimer.start()
	
	if state == CHARGING:
		if $".."/Peppah.position.y == 35:
			timeleftpeppah = $".."/Peppah/ChargingTimer.time_left
			$".."/Peppah/PeppahSprite.modulate = Color(timeleftpeppah/6,1,1)
		if laughingoneshot == true:
			laughingoneshot = false
			$Laughing.play()
		$TooLongTimer.stop()
		position = Vector2(0,96)
		rotation = 0
		$ChargingParticles.emitting = true
	
	if state == CHARGING2:
		if audiooneshot == true:
			audiooneshot = false
			$AudioStreamPlayer.play()
		$ChargingParticles.emitting = false
		if dashrng == 2:
			pass
		if dashrng == 0 and cooldown == 0:
			$RPeppah.emitting = true
			cooldown = 1
		if dashrng == 1 and cooldown == 0:
			$LPeppah.emitting = true
			cooldown = 1
	
	if state == HEALING:
		$".."/Peppah.state = $".."/Peppah.HEALING
		if seboneshot == true:
			seboneshot = false
			$".."/Peppah/PeppahSprite.modulate = Color(1,0,0)
			$".."/".."/Player/MEGA.emitting = false
			$No.play()
		rotation = 0
		position.y = 182
		var peppahpos = $".."/Peppah.position.x
		if abs(peppahpos - position.x) < 40 and oneshothealing == true:
			oneshothealing = false
			$HealingTimer.start()
			$HealingParticles.visible = true
			$HealingParticles.emitting = true
		elif abs(peppahpos - position.x) < 40:
			pass
		elif peppahpos > position.x:
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(30,0),Vector2(0,1))
		elif peppahpos < position.x:
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(-30,0),Vector2(0,1))
		if position.y > 184:
			position.y = 182
		if position.y < 180:
			position.y = 182
		if $HealingParticles.visible == true:
			timeleft = $HealingTimer.time_left
			$".."/Peppah/PeppahSprite.modulate = Color(1,1-timeleft/7,1-timeleft/7)
		if $".."/".."/Runes/DestroyRune/DestroyParticles.emitting == true and oneshotrune1 == true:
			oneshotrune1 = true
			if $StunTimer.time_left < 5:
				$StunTimer.stop()
				$StunTimer.start()
			else:
				$StunTimer.start()
			$HealingTimer.paused = true
			modulate = Color8(150,150,150,255)
			$HealingParticles.emitting = false
		if $".."/".."/Runes/DestroyRune2/DestroyParticles.emitting == true and oneshotrune2 == true:
			oneshotrune2 = true
			if $StunTimer.time_left < 5:
				$StunTimer.stop()
				$StunTimer.start()
			else:
				$StunTimer.start()
			$HealingTimer.paused = true
			modulate = Color8(150,150,150,255)
			$HealingParticles.emitting = false
	
	if state == RESET:
		$".."/Peppah/PeppahSprite.modulate = Color(1,1,1)
		audiooneshot = true
		seboneshot = true
		$HealingParticles.visible = false
		if -1.5 > position.x:
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(150,0),Vector2(0,1))
		elif 1.5 < position.x:
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(-150,0),Vector2(0,1))
		if position.y > 97:
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(0,-150),Vector2(0,1))
		else:
			pass

func _process(delta):
	if cooldown == 1 and oneshot == 0 and $".."/Peppah.phase == 0:
		$Timer0.start()
		oneshot = 1
	elif cooldown == 1 and oneshot == 0 and $".."/Peppah.phase == 1:
		$Timer1.start()
		oneshot = 1
	elif cooldown == 1 and oneshot == 0 and $".."/Peppah.phase == 2:
		$Timer2.start()
		oneshot = 1
	elif cooldown == 1 and oneshot == 0 and $".."/Peppah.phase == 3:
		$Timer3.start()
		oneshot = 1
	elif cooldown == 1 and oneshot == 0 and $".."/Peppah.phase >= 4:
		$Timer4.start()
		oneshot = 1
	if $".."/Peppah.state == $".."/Peppah.DASHING:
		state = PREDICT
	if $".."/Peppah.state == $".."/Peppah.OFFSCREEN:
		state = FLYING
	if $".."/Peppah.state == $".."/Peppah.CHARGING:
		state = CHARGING
	if $".."/Peppah.state == $".."/Peppah.MEGADASH:
		state = CHARGING2
	if $".."/Peppah.state == $".."/Peppah.HEALING:
		state = HEALING
	if health <= 0:
		state = DEAD
		modulate.a -= 0.005
		$".."/".."/KillParticles.position = position
		if delta:
			i += delta/8
		$".."/".."/Bog/ColorRect.material.set("shader_param/multiplier",clamp(i,-15,0.75))
		$No.volume_db = -50
		if killed == false:
			$WinTimer.start()
			$WinTimerShort.start()
			
			$".."/".."/explosion.visible = true
			$".."/".."/explosion.play()
			$".."/".."/explosionaudio.play()
			
			$".."/".."/Player.rotation = 0
			$".."/".."/Player.position.x = 0
			$".."/".."/Player.position.y = 202.5
			$".."/".."/Player/AnimationPlayer.play("WinSequence")
			$".."/".."/Player.state = $".."/".."/Player.END
			
			$SEB.play()
			i = $".."/".."/Bog/ColorRect.material.get("shader_param/multiplier")
			
			$".."/".."/Player/MEGA.emitting = false
			
			$".."/Peppah.state = $".."/Peppah.DEATH
			$".."/".."/KillParticles.emitting = true
			$".."/".."/Music/Background1.volume_db = -80
			$".."/".."/Music/Background2.volume_db = -80
			$".."/".."/Music/Background1.stop()
			$".."/".."/Music/Background2.stop()
			$".."/".."/KillSound.playing = true
			
			$".."/".."/Runes/RuneL1/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneL2/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneL3/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneL4/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneL5/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneR1/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneR2/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneR3/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneR4/DestroyParticles.emitting = true
			$".."/".."/Runes/RuneR5/DestroyParticles.emitting = true
			
			$".."/".."/Runes/RuneL1.texture = null
			$".."/".."/Runes/RuneL2.texture = null
			$".."/".."/Runes/RuneL3.texture = null
			$".."/".."/Runes/RuneL4.texture = null
			$".."/".."/Runes/RuneL5.texture = null
			$".."/".."/Runes/RuneR1.texture = null
			$".."/".."/Runes/RuneR2.texture = null
			$".."/".."/Runes/RuneR3.texture = null
			$".."/".."/Runes/RuneR4.texture = null
			$".."/".."/Runes/RuneR5.texture = null
			
			$".."/".."/BogParticles.emitting = false
			$".."/".."/Bog/TheBog.stop()
			killed = true
	
	if inrange == true and canbehit == true:
		if $".."/".."/Player.state == $".."/".."/Player.TJUMPING:
			
			$".."/".."/Player.state = $".."/".."/Player.FALLING
			$".."/".."/Player.velocity.y = -30
			$".."/".."/Player.velocity.x = $".."/".."/Player.triplev*-100
			
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
			damage = clamp($".."/".."/Player.velocity.x/2, 50, 100)
			health -= damage
			$".."/".."/CanvasLayer/HP/ProgressBar.value = health
			$HitTimer.start()
			modulate = Color8(255,100,100,255)
			
			$".."/".."/"background"/"Mars-dunes1".modulate.a = (1-health/2300)
			$".."/".."/"background"/"Mars-dunes2".modulate.a = (1-health/2300)
			$".."/".."/"background"/"Mars-dunes3".modulate.a = (1-health/2300)
			$".."/".."/"background"/"Mars-dunes4".modulate.a = (1-health/2300)		
			
		if $".."/".."/Player.state == $".."/".."/Player.DJUMPING:
			
			if $".."/".."/Player/PlayerSprite.animation.begins_with("walkright"):
				playerv = -50
			else:
				playerv = 50
			$".."/".."/Player.state = $".."/".."/Player.FALLING
			$".."/".."/Player.velocity.y = -75
			$".."/".."/Player.velocity.x = playerv
			
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
			damage = clamp($".."/".."/Player.velocity.x/2, 25, 50)
			health -= damage
			$".."/".."/CanvasLayer/HP/ProgressBar.value = health
			$HitTimer.start()
			modulate = Color8(255,100,100,255)
			
			$".."/".."/"background"/"Mars-dunes1".modulate.a = (1-health/2300)
			$".."/".."/"background"/"Mars-dunes2".modulate.a = (1-health/2300)
			$".."/".."/"background"/"Mars-dunes3".modulate.a = (1-health/2300)
			$".."/".."/"background"/"Mars-dunes4".modulate.a = (1-health/2300)

func _on_Timer_timeout():
	if killed == true:
		pass
	else:
		cooldown = 0
		oneshot = 0

func _on_Arena_body_entered(body):
	if body.name == "Player":
		pside = "right"
func _on_Arena_body_exited(body):
	if body.name == "Player":
		pside = "left"

func _on_StunTimer_timeout():
	if killed == true:
		pass
	else:
		$HealingTimer.paused = false
		modulate = Color8(255,255,255,255)
		$HealingParticles.emitting = true

func _on_HitArea2D_body_entered(body):
	if killed == true:
		pass
	elif body.name == "Player":
		inrange = true

func _on_HitArea2D_body_exited(body):
	if body.name == "Player":
		inrange = false

func _on_HitTimer_timeout():
	if killed == true:
		pass
	else:
		canbehit = true
		modulate = Color8(255,255,255,255)

func _on_Timer1_timeout():
	if killed == true:
		pass
	else:
		cooldown = 0
		oneshot = 0

func _on_Timer2_timeout():
	if killed == true:
		pass
	else:
		cooldown = 0
		oneshot = 0

func _on_Timer3_timeout():
	if killed == true:
		pass
	else:
		cooldown = 0
		oneshot = 0

func _on_WinTimer_timeout():
	$".."/".."/Player.position = Vector2(0,1000)
	$".."/".."/Endscreen/Control.visible = true

func _on_WinTimerShort_timeout():
	$CollisionShape2D.disabled = true
	$".."/Peppah/CollisionShape2D2.disabled = true
	$".."/".."/Rocks.visible = false
	$".."/".."/Runes.visible = false
	$".."/".."/Area2D/CollisionShape2D.disabled = true
	$".."/".."/Area2D/CollisionShape2D2.disabled = true

func _on_Timer4_timeout():
	if killed == true:
		pass
	else:
		cooldown = 0
		oneshot = 0
