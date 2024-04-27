extends KinematicBody2D

var state = START
const GOTODASH = 0; const DASHING = 1; const OFFSCREEN = 2; const WALKING = 3; const JUMPING = 4; const CHARGING = 5;
const MEGADASH = 6; const HEALING = 7; const DEATH = 8; const MEGADASHING = 9; const RESET = 10; const START = 11;

var gravity = 10
var velocity = Vector2()

#GOTODASH AND DASHING
var dashrng
var side = ""
var started = false
var oneshotdash = true

#WALKING
var cooldown = 0
var i = true

#CHARGING
var charging = false
var timeleft = 0

#PHASES
var phase = 0
var phasezeroshot = true
var deltazero = 0.75
var phaseoneshot = true
var deltaone = 0.5
var phasetwoshot = true
var deltatwo = 0.25
var phasethreeshot = true
var deltathree = 0
var phasefourshot = true
var deltafour = -0.25

#START
var oneshotstart = true

# PLAYER HIT
var playerhit = false

func _ready():
	$".."/".."/Music/Background1.volume_db = -15
	$".."/".."/Music/Background2.volume_db = -10

func _physics_process(delta):
	$".."/".."/Player/PeppahWarning.global_rotation = 0
	$".."/".."/Player/PeppahWarning.global_position.y = 100
	$".."/".."/Player/PeppahWarning.global_position.x = $".."/".."/Player.position.x
	
	if phase == 0 and $".."/Nina.killed == false:
		deltazero -= delta/25
		$".."/".."/Bog/ColorRect.material.set("shader_param/multiplier",clamp(deltazero,0.5,0.75))
		if phasezeroshot == true:
			$".."/".."/Music/Background1.volume_db -= 2.5
			$".."/".."/Music/Background2.volume_db -= 2.5
			$".."/".."/BogParticles.position.y = -150
			phasezeroshot = false
	if phase == 1 and $".."/Nina.killed == false:
		deltaone -= delta/25
		$".."/".."/Bog/ColorRect.material.set("shader_param/multiplier",clamp(deltaone,0.25,0.5))
		if phaseoneshot == true:
			$".."/".."/Music/Background1.volume_db -= 2.5
			$".."/".."/Music/Background2.volume_db -= 2.5
			$".."/".."/Bog/TheBog.volume_db = -15
			$".."/".."/Bog/TheBog.play()
			$".."/".."/BogParticles.position.y = -100
			$AudioStreamPlayer2D.volume_db -=5
			$".."/Nina/AudioStreamPlayer.volume_db -= 5
			$".."/Nina/No.volume_db -= 5
			$".."/Nina/Laughing.volume_db -= 5
			$".."/Nina/BogParticles2.amount = 25
			$".."/".."/Rocks/xQcNO.volume_db -= 5
			
			$Blip.volume_db -= 4; $commence.volume_db -= 4
			$crash1.volume_db -= 4; $crash2.volume_db -= 4; $crash3.volume_db -= 4
			$crash4.volume_db -= 4; $crash5.volume_db -= 4
			
			$".."/".."/Runes/runeselect.volume_db -= 5
			$".."/".."/Runes/runeselect2.volume_db -= 5
			$".."/".."/Runes/runeselect3.volume_db -= 5
			$".."/".."/Runes/runeselect4.volume_db -= 5
			$".."/".."/Runes/runeselect5.volume_db -= 5
			$".."/".."/Runes/runeselect6.volume_db -= 5
			$".."/".."/Runes/buffsound.volume_db -= 5
			$".."/".."/Runes/explosion1.volume_db -= 5
			$".."/".."/Runes/explosion2.volume_db -= 5
			$".."/".."/Runes/explosion3.volume_db -= 5
			$".."/".."/Runes/explosion4.volume_db -= 5
			$".."/".."/Runes/explosion5.volume_db -= 5
			
			phaseoneshot = false
	if phase == 2 and $".."/Nina.killed == false:
		deltatwo -= delta/25
		$".."/".."/Bog/ColorRect.material.set("shader_param/multiplier",clamp(deltatwo,0,0.25))
		if phasetwoshot == true:
			$".."/".."/CanvasLayer/Warning.visible = true
			$".."/".."/Music/Background1.volume_db -= 2.5
			$".."/".."/Music/Background2.volume_db -= 2.5
			$".."/".."/Bog/TheBog.volume_db = -5
			$".."/".."/Bog/TheBog.play()
			$".."/".."/BogParticles.position.y = -80
			$AudioStreamPlayer2D.volume_db -=5
			$".."/Nina/AudioStreamPlayer.volume_db -= 5
			$".."/Nina/No.volume_db -= 5
			$".."/Nina/Laughing.volume_db -= 5
			$".."/Nina/BogParticles2.amount = 50
			$".."/".."/Rocks/xQcNO.volume_db -= 5
			
			$Blip.volume_db -= 4; $commence.volume_db -= 4
			$crash1.volume_db -= 4; $crash2.volume_db -= 4; $crash3.volume_db -= 4
			$crash4.volume_db -= 4; $crash5.volume_db -= 4
			
			$".."/".."/Runes/runeselect.volume_db -= 5
			$".."/".."/Runes/runeselect2.volume_db -= 5
			$".."/".."/Runes/runeselect3.volume_db -= 5
			$".."/".."/Runes/runeselect4.volume_db -= 5
			$".."/".."/Runes/runeselect5.volume_db -= 5
			$".."/".."/Runes/runeselect6.volume_db -= 5
			$".."/".."/Runes/buffsound.volume_db -= 5
			$".."/".."/Runes/explosion1.volume_db -= 5
			$".."/".."/Runes/explosion2.volume_db -= 5
			$".."/".."/Runes/explosion3.volume_db -= 5
			$".."/".."/Runes/explosion4.volume_db -= 5
			$".."/".."/Runes/explosion5.volume_db -= 5
			
			phasetwoshot = false
	if phase == 3 and $".."/Nina.killed == false:
		deltathree -= delta/25
		$".."/".."/Bog/ColorRect.material.set("shader_param/multiplier",clamp(deltathree,-0.25,0))
		if phasethreeshot == true:
			$".."/".."/CanvasLayer/Trigger.visible = true
			$".."/".."/Music/Background1.volume_db -= 2.5
			$".."/".."/Music/Background2.volume_db -= 2.5
			$".."/".."/Bog/TheBog.volume_db = 0
			$".."/".."/Bog/TheBog.play()
			$".."/".."/BogParticles.position.y = -50
			$AudioStreamPlayer2D.volume_db -=5
			$".."/Nina/AudioStreamPlayer.volume_db -= 5
			$".."/Nina/No.volume_db -= 5
			$".."/Nina/Laughing.volume_db -= 5
			$".."/Nina/BogParticles2.amount = 100
			$".."/".."/Rocks/xQcNO.volume_db -= 5
			
			$Blip.volume_db -= 4; $commence.volume_db -= 4
			$crash1.volume_db -= 4; $crash2.volume_db -= 4; $crash3.volume_db -= 4
			$crash4.volume_db -= 4; $crash5.volume_db -= 4
			
			$".."/".."/Runes/runeselect.volume_db -= 5
			$".."/".."/Runes/runeselect2.volume_db -= 5
			$".."/".."/Runes/runeselect3.volume_db -= 5
			$".."/".."/Runes/runeselect4.volume_db -= 5
			$".."/".."/Runes/runeselect5.volume_db -= 5
			$".."/".."/Runes/runeselect6.volume_db -= 5
			$".."/".."/Runes/buffsound.volume_db -= 5
			$".."/".."/Runes/explosion1.volume_db -= 5
			$".."/".."/Runes/explosion2.volume_db -= 5
			$".."/".."/Runes/explosion3.volume_db -= 5
			$".."/".."/Runes/explosion4.volume_db -= 5
			$".."/".."/Runes/explosion5.volume_db -= 5
			
			phasethreeshot = false
	if phase == 4 and $".."/Nina.killed == false:
		deltafour -= delta
		$".."/".."/Bog/ColorRect.material.set("shader_param/multiplier",clamp(deltafour,-10,-0.25))
		if phasefourshot == true:
			$".."/".."/CanvasLayer/Trigger2.visible = true
			$".."/".."/Music/Background1.volume_db -= 50
			$".."/".."/Music/Background2.volume_db -= 50
			$".."/".."/Music/Background1.stop()
			$".."/".."/Music/Background2.stop()
			$".."/".."/Bog/TheBog.volume_db = 5
			$".."/".."/Bog/TheBog.play()
			$".."/".."/BogParticles.position.y = 0
			$AudioStreamPlayer2D.volume_db -=5
			$".."/Nina/AudioStreamPlayer.volume_db -= 5
			$".."/Nina/No.volume_db -= 5
			$".."/Nina/Laughing.volume_db -= 5
			$".."/Nina/BogParticles2.amount = 200
			$".."/".."/Rocks/xQcNO.volume_db -= 5
			
			$Blip.volume_db -= 5; $commence.volume_db -= 5
			$crash1.volume_db -= 4; $crash2.volume_db -= 4; $crash3.volume_db -= 4
			$crash4.volume_db -= 4; $crash5.volume_db -= 4
			
			$".."/".."/Runes/runeselect.volume_db -= 5
			$".."/".."/Runes/runeselect2.volume_db -= 5
			$".."/".."/Runes/runeselect3.volume_db -= 5
			$".."/".."/Runes/runeselect4.volume_db -= 5
			$".."/".."/Runes/runeselect5.volume_db -= 5
			$".."/".."/Runes/runeselect6.volume_db -= 5
			$".."/".."/Runes/buffsound.volume_db -= 5
			$".."/".."/Runes/explosion1.volume_db -= 5
			$".."/".."/Runes/explosion2.volume_db -= 5
			$".."/".."/Runes/explosion3.volume_db -= 5
			$".."/".."/Runes/explosion4.volume_db -= 5
			$".."/".."/Runes/explosion5.volume_db -= 5
			
			phasefourshot = false

	if cooldown == 0:
		$Timer.start()

	if state != CHARGING:
		if state != RESET:
			if state != DEATH:
				if state != HEALING:
					velocity.y += gravity
	velocity = move_and_slide(velocity,Vector2(0,-1))

	if state == START and oneshotstart == true:
		oneshotstart = false
		yield(get_tree().create_timer(1), "timeout")
		state = GOTODASH
	
	if state == GOTODASH:
		var timeDict = OS.get_time();
		var osseconds = timeDict.second;
		dashrng = osseconds%2
		$".."/Nina.dashrng = dashrng
		started = false
		if dashrng == 0:
			side = "right"
			state = DASHING
		elif dashrng == 1:
			$PeppahSprite.flip_h = true
			side = "left"
			state = DASHING

	if state == DASHING:
		$".."/".."/CanvasLayer/Warning.visible = false
		$".."/".."/CanvasLayer/Trigger.visible = false
		$".."/".."/CanvasLayer/Trigger2.visible = false
		cooldown = 0
		if oneshotdash == true:
			oneshotdash = false
			$AudioStreamPlayer2D.play()
		if side == "right" and started == false:
			position.x = 520
			velocity.x = -500
			started = true
		if side == "left" and started == false:
			position.x = -520
			velocity.x = 500
			started = true

	if state == WALKING:
		if $".."/".."/Player.position.x > position.x:
			$PeppahSprite.flip_h = true
			velocity.x = lerp(velocity.x,90,0.7)
		elif $".."/".."/Player.position.x < position.x:
			$PeppahSprite.flip_h = false
			velocity.x = lerp(velocity.x,-90,0.7)
		if abs($".."/".."/Player.position.x - position.x) <= 100 and cooldown == 0:
			state = JUMPING
			cooldown = 1
			i = true
		if $".."/".."/Rocks.leftdone == true and $".."/".."/Rocks.rightdone == true:
			state = CHARGING

	if state == JUMPING:
		if $PeppahSprite.flip_h == true and i == true:
			i = false
			velocity.x = 170
			velocity.y -= 200
		elif $PeppahSprite.flip_h == false and i == true:
			i = false
			velocity.x = -170
			velocity.y -= 200
		if is_on_floor() and velocity.y > -1:
			$Particles2D.emitting = true
			var rng83523 = randf()
			if rng83523 >= 0.8:
				$crash1.play()
			elif rng83523 >= 0.6:
				$crash2.play()
			elif rng83523 >= 0.4:
				$crash3.play()
			elif rng83523 >= 0.2:
				$crash4.play()
			elif rng83523 >= 0:
				$crash5.play()
			state = WALKING

	if state == OFFSCREEN:
		$Particles2D.emitting = false
		velocity.x = 0
		position.x = 520
		position.y = 186
		if $".."/Nina.state == $".."/Nina.FLYING:
			if $".."/Nina.pside == "right":
				position.x = -400
				state = WALKING
			if $".."/Nina.pside == "left":
				position.x = 400
				state = WALKING

	if state == CHARGING:
		$".."/".."/Player/PeppahWarning.visible = true
		$".."/Nina.dashrng = 2
		$Particles2D.emitting = false
		if position.y < 0 and charging != true:
			charging = true
			velocity.y = 0
			velocity.x = 0
			position.x = 0
			position.y = 35
			$ChargingTimer.start()
		else:
			if charging != true:
				velocity.y -= 10
		if $".."/Nina.pside == "right":
			$PeppahSprite.flip_h = true
			#$".."/".."/Player/PeppahWarning.flip_h = false
			$".."/".."/Player/PeppahWarning.flip_h = true
		if $".."/Nina.pside == "left":
			$PeppahSprite.flip_h = false
			#$".."/".."/Player/PeppahWarning.flip_h = true
			$".."/".."/Player/PeppahWarning.flip_h = false

	if state == MEGADASH:
		if oneshotdash == true:
			$Blip.play()
			$AudioStreamPlayer2D.play()
			if $".."/Nina.pside == "right":
				dashrng = 0
				$".."/Nina.dashrng = dashrng
			if $".."/Nina.pside == "left":
				dashrng = 1
				$".."/Nina.dashrng = dashrng
			oneshotdash = false
		position.y = 186
		position.x = 1000
		started = false
		yield(get_tree().create_timer(0.5), "timeout")
		if dashrng == 0:
			side = "right"
			state = MEGADASHING
		elif dashrng == 1:
			$PeppahSprite.flip_h = true
			side = "left"
			state = MEGADASHING

	if state == MEGADASHING:
		$".."/".."/Player/PeppahWarning.visible = false
		if side == "right" and started == false:
			$commence.play()
			position.x = 520
			velocity.x = -500
			started = true
		if side == "left" and started == false:
			$commence.play()
			position.x = -520
			velocity.x = 500
			started = true

	if state == HEALING:
		velocity.x = 0
		velocity.y = 0
		$BloodParticles.emitting = true

	if state == RESET:
		$CollisionShape2D2.set_deferred("disabled", false)
		charging = false
# warning-ignore:return_value_discarded
		move_and_slide(Vector2(0,-100),Vector2(0,1))
		if $".."/Nina.killed == true:
			$".."/".."/CanvasLayer/Warning.visible = false
			$".."/".."/CanvasLayer/Trigger.visible = false
			$".."/".."/CanvasLayer/Trigger2.visible = false

	if state == DEATH:
		velocity.x = 0
		velocity.y = 0
		modulate.a -= 0.005

	if playerhit == true:
		$".."/".."/Player.state = $".."/".."/Player.FALLING
		if state == HEALING:
			$".."/".."/Player.velocity.y = -50
			$".."/".."/Player.velocity.x = $".."/".."/Player.triplev*-200
		else:
			$".."/".."/Player.velocity.y = -25
			$".."/".."/Player.velocity.x = $".."/".."/Player.triplev*-100
		playerhit = false

func _on_Area2D_body_entered(body):
	if $".."/Nina.killed == true:
		pass
	elif body.name == "Player":
		if state == DASHING:
			if $".."/".."/Player.triplev == 1 and side == "right":
				velocity.y -= 1000
				playerhit = true
				yield(get_tree().create_timer(1), "timeout")
				state = OFFSCREEN
			elif $".."/".."/Player.triplev == -1 and side == "left":
				velocity.y -= 1000
				playerhit = true
				yield(get_tree().create_timer(1), "timeout")
				state = OFFSCREEN
			else:
				$".."/".."/Player.state = $".."/".."/Player.DEATH
		elif state == MEGADASHING:
			if $".."/".."/Runes.correct < 6:
				$".."/".."/Player.state = $".."/".."/Player.DEATH
			elif $".."/".."/Player.triplev == 1 and side == "right" and $".."/".."/Runes.correct >= 6:
				state = HEALING
				playerhit = true
				$CollisionShape2D2.set_deferred("disabled", true)
				position.y = 186
			elif $".."/".."/Player.triplev == -1 and side == "left" and $".."/".."/Runes.correct >= 6:
				state = HEALING
				playerhit = true
				$CollisionShape2D2.set_deferred("disabled", true)
				position.y = 186
			elif $".."/".."/Player.triplev == 1 and side == "left":
				$".."/".."/Player.state = $".."/".."/Player.DEATH
			elif $".."/".."/Player.triplev == -1 and side == "right":
				$".."/".."/Player.state = $".."/".."/Player.DEATH
			else:
				$".."/".."/Player.state = $".."/".."/Player.DEATH
		elif state == HEALING:
			pass
		elif state == RESET:
			pass
		else:
			$".."/".."/Player.state = $".."/".."/Player.DEATH

func _on_Timer_timeout():
	if $".."/Nina.killed == true:
		pass
	else:
		cooldown = 0

func _on_ChargingTimer_timeout():
	if $".."/Nina.killed == true:
		pass
	else:
		oneshotdash = true
		state = MEGADASH

func _on_HealingTimer_timeout():
	if $".."/Nina.killed == true:
		pass
	else:
		phase += 1
		velocity.x = 0
		state = RESET
		$".."/Nina.state = $".."/Nina.RESET
		$BloodParticles.emitting = false
		yield(get_tree().create_timer(3), "timeout")
		position.x = 520
		position.y = 186
		oneshotdash = true
		state = GOTODASH

func _on_TooLongTimer_timeout():
	if $".."/Nina.killed == true:
		pass
	elif state == WALKING or state == JUMPING:
		state = CHARGING
