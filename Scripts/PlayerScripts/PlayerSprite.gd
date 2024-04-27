extends AnimatedSprite

func _process(_delta): # Walk left/right = animation right/left

	if Input.is_action_pressed("ui_right") and $".."/.state <= 2:
		play("walkright")
	elif Input.is_action_pressed("ui_left") and $".."/.state <= 2:
		play("walkleft")

	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"): # Speed up animation over time
		speed_scale += 0.005
		if speed_scale > 4:
			speed_scale = 4
	else: # Reset speed_scale and frame
		speed_scale = 2
		frame = 3
