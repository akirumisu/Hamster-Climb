extends Node

func _ready():
	if Globalvar.musictime2:
		if Globalvar.musictime2 == null:
			Globalvar.musictime2 = 0
		$Background2.play(Globalvar.musictime2)
	else:
		if Globalvar.musictime1 == null:
			Globalvar.musictime1 = 0
		$Background1.play(Globalvar.musictime1)

func _exit_tree():
	if $Background1.playing:
		Globalvar.musictime1 = $Background1.get_playback_position()
	if $Background2.playing:
		Globalvar.musictime2 = $Background2.get_playback_position()
	else:
		Globalvar.musictime3 = null

func _on_Background1_finished():
	Globalvar.musictime1 = null
	Globalvar.musictime2 = 0
	$Background2.play()

func _on_Background2_finished():
	Globalvar.musictime2 = null
	Globalvar.musictime1 = 0
	$Background1.play()
