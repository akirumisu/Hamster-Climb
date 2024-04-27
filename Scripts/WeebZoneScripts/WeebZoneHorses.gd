extends Node2D

var Horse0Active = false
var Horse1Active = false
var Horse2Active = false

func _ready():
	if Save.data.horse[3] == 1:
		$Horse0.queue_free()
	else:
		Horse0Active = true

	if Save.data.horse[4] == 1:
		$Horse1.queue_free()
	else:
		Horse1Active = true

	if Save.data.horse[5] == 1:
		$Horse2.queue_free()
	else:
		Horse2Active = true

func _physics_process(delta):
	if Horse0Active:
		$Horse0.rotation_degrees += delta*50
	
	if Horse1Active:
		$Horse1.rotation_degrees += delta*50

	if Horse2Active:
		$Horse2.rotation_degrees += delta*50

func _on_Horse0Area2D_body_entered(body):
	if body.name == "Player":
		Horse0Active = false
		Save.data.horse[3] = 1
		Save.data.horses +=1
		Globalvar.horses +=1
		$HorseEffect.play()
		$Horse0.queue_free()

func _on_Horse1Area2D_body_entered(body):
	if body.name == "Player":
		Horse1Active = false
		Save.data.horse[4] = 1
		Save.data.horses +=1
		Globalvar.horses +=1
		$HorseEffect.play()
		$Horse1.queue_free()

func _on_Horse2Area2D_body_entered(body):
	if body.name == "Player":
		Horse2Active = false
		Save.data.horse[5] = 1
		Save.data.horses +=1
		Globalvar.horses +=1
		$HorseEffect.play()
		$Horse2.queue_free()
