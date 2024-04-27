extends Node2D

const HORSE = preload("res://Scenes/Secret/horses.tscn")

var time = 0
var milliseconds
var seconds
var minutes
var str_elapsed
var strtext

func moreHorse():
	var horse = HORSE.instance()
	$"..".add_child(horse)

func _on_moreHorseTimer_timeout():
	moreHorse()

func _ready():
	if Save.data.recordSecret >= 37:
		$".."/CanvasLayer/Time/Top/target.visible = false
		Save.data.clearedSecret = 1
		Save.save_data()
	milliseconds = int(Save.data.recordSecret*1000)%1000
	seconds = int(Save.data.recordSecret)%60
	minutes = int(Save.data.recordSecret/60)%60
	str_elapsed = "%02d:%02d.%03d" % [minutes, seconds, milliseconds]
	strtext = str(str_elapsed)
	$".."/CanvasLayer/Time/Top/record.text = strtext

func _process(delta):
	time += delta
	milliseconds = int(time*1000)%1000
	seconds = int(time)%60
	minutes = int(time/60)%60
	str_elapsed = "%02d:%02d.%03d" % [minutes, seconds, milliseconds]
	strtext = str(str_elapsed)
	$".."/CanvasLayer/Time/Top/time.text = strtext
	if Save.data.recordSecret < time:
		Save.data.recordSecret = time
		$".."/CanvasLayer/Time/Top/record.text = strtext
