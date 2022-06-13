extends Control



func _on_Knight_mouse_entered():
	$Knight/AnimationPlayer.play("idle")


func _on_Knight_mouse_exited():
	$Knight/AnimationPlayer.stop()


func _on_Astro_mouse_entered():
	$Astro/AnimationPlayer.play("idle")


func _on_Astro_mouse_exited():
	$Astro/AnimationPlayer.stop()


func _on_Knight_pressed():
	get_tree().change_scene("res://map/GameKnight.tscn")


func _on_Astro_pressed():
	get_tree().change_scene("res://map/GameAstro.tscn")


func _on_BackButton_pressed():
	self.visible = false
