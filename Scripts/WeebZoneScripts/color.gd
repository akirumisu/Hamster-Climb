extends Node2D

var red = 0 #damage down
var green = 0 #INSANITY
var blue = 0 #speed down
var purple = 0 #damage up + INSOMNIA
var yellow = 0 #speed up + PYSCHOSIS

var oneshotred = true
var oneshotgreen = true
var oneshotblue = true
var oneshotpurple = true
var oneshotyellow = true

var redlabel = false
var greenlabel = false
var bluelabel = false
var purplelabel = false
var yellowlabel = false

var timeroneshot = true

func _process(_delta):
	global_rotation = 0
# ONE SHOT PARTICLES START EMITTING
	if red > 0 and oneshotred == true:
		$red.emitting = true
		oneshotred = false
	if green > 0 and oneshotgreen == true:
		$green.emitting = true
		oneshotgreen = false
	if blue > 0 and oneshotblue == true:
		$blue.emitting = true
		oneshotblue = false
	if purple > 0 and oneshotpurple == true:
		$purple.emitting = true
		$BogParticlesColor.emitting = true
		oneshotpurple = false
	if yellow > 0 and oneshotyellow == true:
		$yellow.emitting = true
		oneshotyellow = false
# LABEL CODE
	if redlabel == true or greenlabel == true or bluelabel == true or purplelabel == true or yellowlabel == true:
		if timeroneshot == true:
			timeroneshot = false
			$Timer.start()
		if redlabel == true:
			$Labels/redlabel.visible = true
		if greenlabel == true:
			$Labels/greenlabel.visible = true
		if bluelabel == true:
			$Labels/bluelabel.visible = true
		if purplelabel == true:
			$Labels/purplelabel.visible = true
		if yellowlabel == true:
			$Labels/yellowlabel.visible = true
# HEALTH + DEATH CODE
	$".."/".."/CanvasLayer/Levels/HealthLabel.text = str(5-(red + green + blue + purple + yellow))
	if (red + green + blue + purple + yellow >= 5) and $".."/".."/xqc.health > 0:
		$"..".state = $"..".DEATH
# CHANGE STATS CODE
	$".."/".."/xqc.pdamage = 1 -(red*0.1) +(purple*0.2)
	$"..".SPEED = float(100-(blue*5)+(yellow*10))

func _on_Timer_timeout():
	timeroneshot = true
	redlabel = false
	$Labels/redlabel.visible = false
	if $Labels/greenlabel.visible == true:
		$Labels/greenlabel.visible = false
		greenlabel = false
	bluelabel = false
	$Labels/bluelabel.visible = false
	if $Labels/purplelabel.visible == true:
		$Labels/purplelabel.visible = false
		purplelabel = false
		$BogParticlesColor.amount += 25
	if $Labels/yellowlabel.visible == true:
		$Labels/yellowlabel.visible = false
		yellowlabel = false
		if yellow == 1:
			$".."/".."/xqc/Sprite2.visible = true
		if yellow == 2:
			$".."/".."/xqc/Sprite3.visible = true
		if yellow == 3:
			$".."/".."/xqc/Sprite4.visible = true
		if yellow == 4:
			$".."/".."/xqc/Sprite5.visible = true
