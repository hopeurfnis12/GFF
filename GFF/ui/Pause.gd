extends Control

export(bool) var can_toggle_pause = true


func _process(delta):
	if Input.is_action_just_pressed("menu_pause"):
		if !get_tree().paused: pause()
		else: resume()


func pause():
	if can_toggle_pause:
		self.visible = true
		get_tree().set_deferred("paused", true)


func resume():
	if can_toggle_pause:
		self.visible = false
		get_tree().set_deferred("paused", false)


func _on_ResumeButton_pressed():
	if can_toggle_pause:
		self.visible = false
		get_tree().set_deferred("paused", false)


func _on_ExtitToMenuButton_pressed():
	get_tree().set_deferred("paused", false)
	get_tree().change_scene("res://Main.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
