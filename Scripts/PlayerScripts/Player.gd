extends KinematicBody2D

var SPEED = float(100)
const JUMP_POWER = float(-210)
const ACCELERATION = 0.2
const FRICTION = 0.6

var gravity = 10

var velocity = Vector2()

var triplev = 0 #velocity during triple jump: 1 or -1
var tripler #rotation during triple jump

var state = 0

const ONGROUND = 0; const JUMPING = 1; const DJUMPING = 2; const TJUMPING = 3;
const DEATH = 5; const FALLING = 6; const SLIDING = 7; const END = 8;

var old_rotation = 0

var rng = 2
var rng2 = 2

var fallshot = false

var sloped = false

var bosslevel

var coyotetime = false
var groundx = 0
var groundy = 0

func _ready():
	state = FALLING

func _physics_process(delta):
	
	if state == SLIDING:
		
		var _error = move_and_slide(velocity,Vector2(0,-1))
		
		
		if get_slide_count()>0:
			var collision = get_slide_collision(0)
			var normal = collision.normal
			var angleDelta = normal.angle() - (rotation - PI)
			rotation = angleDelta + rotation
		
		velocity.x = lerp(velocity.x, 0, 0.04)
		
		if abs(velocity.x) <= 2:
			state = FALLING
	
	if state == FALLING:
		
		var animation = $PlayerSprite.animation
		if animation == "walkleft":
			rotation += velocity.x/1000
		if animation == "walkright":
			rotation += velocity.x/1000
		
		if fallshot == true:
			$DeathSounds/FallingNoise.play()
			fallshot = false
	
	if state == TJUMPING: #triple jumping
		
		if Input.is_action_pressed("ui_right"):
			if triplev == 1:
				velocity.x = lerp(velocity.x,SPEED/5,ACCELERATION)
			elif triplev == -1:
				#velocity.x = lerp(velocity.x,SPEED/5,ACCELERATION)
				pass
		elif Input.is_action_pressed("ui_left"):
			if triplev == 1:
				#velocity.x = lerp(velocity.x,-SPEED/5,ACCELERATION)
				pass
			elif triplev == -1:
				velocity.x = lerp(velocity.x,-SPEED/5,ACCELERATION)
		else:
			velocity.x = lerp(velocity.x, 0, FRICTION)
		
		var _error = move_and_slide(Vector2(abs(tripler*3)*SPEED/3*triplev,(abs(tripler)-PI)*25+JUMP_POWER/3))
		
		if triplev == 1 and rotation_degrees > -180:
			rotation_degrees+=1.5
			rotation = clamp(rotation,0,(PI/2)-0.05)
		elif triplev == -1 and rotation_degrees > -180:
			rotation_degrees-=1.5
			rotation = clamp(rotation,-(PI/2)+0.05,0)
			
	if state == DJUMPING: #double jumping > triple jump
		
		if Input.is_action_pressed("ui_right"):
			velocity.x = lerp(velocity.x,SPEED,ACCELERATION)
		elif Input.is_action_pressed("ui_left"):
			velocity.x = lerp(velocity.x,-SPEED,ACCELERATION)
		else:
			velocity.x = lerp(velocity.x, 0, FRICTION)
		
		if $PlayerSprite.animation.begins_with("walkright"):
			rotation_degrees+=4
			#rotation = clamp(rotation,0,(PI/2)+0.1)
		if $PlayerSprite.animation.begins_with("walkleft"):
			rotation_degrees-=4
			#rotation = clamp(rotation,-(PI/2)-0.1,0)
		
		#triple jump
		if Input.is_action_just_pressed("ui_accept"):
			tripler = rotation
			state = TJUMPING
			if $PlayerSprite.animation.begins_with("walkright"):
				triplev = 1 #velocity diriection during triple jump
			elif $PlayerSprite.animation.begins_with("walkleft"):
				triplev = -1
			
	if state == JUMPING: #jumping > double jump
		rotation_degrees = 0
		
		if Input.is_action_pressed("ui_right"):
			velocity.x = lerp(velocity.x,SPEED,ACCELERATION)
		elif Input.is_action_pressed("ui_left"):
			velocity.x = lerp(velocity.x,-SPEED,ACCELERATION)
		else:
			velocity.x = lerp(velocity.x, 0, FRICTION)
			
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_POWER/1.5
			state = DJUMPING
		
		if Input.is_action_just_released("ui_accept") and velocity.y < -160:
			while velocity.y < -80:
				velocity.y += 1
		elif Input.is_action_just_released("ui_accept") and velocity.y < -80:
			while velocity.y < -40:
				velocity.y += 1
			
	if state == ONGROUND: #on ground > jump
		
		fallshot = true
		triplev = 0
		rotation_degrees = 0
		
		if Input.is_action_pressed("ui_right"):
			velocity.x = lerp(velocity.x,SPEED,ACCELERATION)
		elif Input.is_action_pressed("ui_left"):
			velocity.x = lerp(velocity.x,-SPEED,ACCELERATION)
		else:
			velocity.x = lerp(velocity.x, 0, FRICTION)
			
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_POWER
			
		if !is_on_floor():
			if Input.is_action_pressed("ui_accept"):
				state = JUMPING
			elif coyotetime == false:
				coyotetime = true
				$CoyoteTimer.start()
			
	if state == DEATH: #death
		if Globalvar.animationsettings == false:
			if Save.data.godgamer == true:
				Globalvar.godgamerdeath = true
				var _error = get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")
			#yield(get_tree().create_timer(0.1), "timeout")
			var _error = get_tree().reload_current_scene()
		if Save.data.godgamer == true and Globalvar.godgamerdeath == false: # One time ran Godgamer
			$".."/Music/Background1.volume_db = -80
			$".."/Music/Background2.volume_db = -80
			$DeathSounds/hardcoredeath.play()
			Globalvar.godgamerdeath = true
		elif Save.data.godgamer == false and rng > 1: # One time normal
			rng = 0
			$DeathSounds/death1.play()
			$".."/CanvasLayer/Transition/AnimationPlayer.playback_speed = 0.6
			$".."/CanvasLayer/Transition/AnimationPlayer.play("fade_out")
			
		if $Particles2D.emitting == false: # One time ran always
			Save.data.deaths += 1
		$Particles2D.emitting = true
		if scale.x and scale.y > 0 and Save.data.godgamer == false:
			scale.x -= delta*1.5
			scale.y -= delta*1.5
		if scale.x and scale.y > 0 and Save.data.godgamer == true:
			scale.x -= delta*0.15
			scale.y -= delta*0.15
		if rotation == 0:
			if velocity.x < 25:
				rotation = 80
			else:
				rotation = velocity.x/PI
		
	if state != DEATH and state != END and sloped == false:
		
		velocity.y += gravity
		
		if state == DJUMPING:
			velocity = move_and_slide(velocity,Vector2(0,-1), false, 4, PI/6.5)
		elif state == DJUMPING and rotation > PI:
			velocity = move_and_slide(velocity,Vector2(0,-1), false, 4, PI/1)
		elif state == TJUMPING:
			velocity = move_and_slide(velocity,Vector2(0,-1), false, 4, PI/7)
		else:
			velocity = move_and_slide(velocity,Vector2(0,-1), false, 4, PI/5)
		
		if (is_on_floor() and state != SLIDING):
			groundx = position.x
			groundy = position.y
			if state == DJUMPING:
				old_rotation = rotation
				if abs(rotation) >= PI/1.3:
					pass
				if rotation <= PI/2:
					rotation_degrees = lerp(rotation_degrees,0,0.725)
					position.x += old_rotation*1.75
					if is_on_floor():
						position.y -= 2
				if rotation > PI/2:
					rotation_degrees = lerp(rotation_degrees,0,0.725)
					position.x += (PI-old_rotation)*1.75
					if is_on_floor():
						position.y -= 2
			if state == TJUMPING:
				if abs(rotation) >= PI/1.3:
					pass
				if rotation <= PI/2:
					rotation_degrees = lerp(rotation_degrees,0,0.725)
					position.x += old_rotation*1
					if is_on_floor():
						position.y -= 2
				if rotation > PI/2:
					rotation_degrees = lerp(rotation_degrees,0,0.725)
					position.x += old_rotation*1
					if is_on_floor():
						position.y -= 2
			if state == FALLING:
				if is_on_floor():
					state = ONGROUND
					position.y -= 1
			state = ONGROUND
		
		if Input.is_action_pressed("ui_down"):
			velocity.y += 10
			
		if velocity.x == 0:
			$PlayerSprite.stop()
		
	if sloped == true:
		velocity.y += gravity
		velocity = move_and_slide(velocity*1,Vector2(0,-1))
		
	if is_on_wall() and (state == JUMPING or state == DJUMPING or state == TJUMPING) and sloped == false and bosslevel != true:
		if rotation < -0.2:
			velocity.x = abs(rotation*3)*SPEED/3*1 + 10
			velocity.y = (abs(rotation)-PI)*25+JUMP_POWER/3
			rng2 = 2
			state = FALLING
		elif rotation > 0.2:
			velocity.x = -abs(rotation*3)*SPEED/3*1 - 10
			velocity.y = (abs(rotation)-PI)*25+JUMP_POWER/3
			rng2 = 2
			state = FALLING
	if is_on_wall() and state == FALLING and sloped == false and bosslevel != true:
		if rotation < -0.1:
			velocity.x = abs(rotation*1)*SPEED/1*1 + 3
		elif rotation > 0.1:
			velocity.x = -abs(rotation*1)*SPEED/1*1 - 3
	
func _on_CoyoteTimer_timeout():
	coyotetime = false
	state = JUMPING
