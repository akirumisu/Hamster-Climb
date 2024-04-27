extends KinematicBody2D

const BULLET = preload("res://Scenes/Asylum/Bullet.tscn")

var timerTime = 4

var moverng = RandomNumberGenerator.new()
var rng1

func _ready():
	$Timer.start()

#func _physics_process(delta):
#	pass

func shoot():
	look_at($".."/Player.position)
	var bullet = BULLET.instance()
	bullet.transform = transform
	bullet.modulate.a = 0.75
	$"..".add_child(bullet)

func move():
	moverng.randomize()
	rng1 = moverng.randi_range(1,4)
	if rng1 == 1:
		position.x = moverng.randi_range(-30,-100)
		position.y = moverng.randi_range(-30,300)
	elif rng1 == 2:
		position.x = moverng.randi_range(510,580)
		position.y = moverng.randi_range(-30,300)
	elif rng1 == 3:
		position.x = moverng.randi_range(-20,500)
		position.y = moverng.randi_range(-100,-30)
	elif rng1 == 4:
		position.x = moverng.randi_range(-20,500)
		position.y = moverng.randi_range(300,370)

func _on_Timer_timeout():
	move()
	shoot()
	timerTime -= 0.25
	if timerTime <= 1:
		$Timer.wait_time = 1
	else:
		$Timer.wait_time = timerTime
	$Timer.start()

func _on_startTimer_timeout():
	shoot()
