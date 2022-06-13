extends Control

const SAVE_FILE_PATH = "user://savedata.save"

var highscore = 0


func _ready():
	load_highscore()


func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()


func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var()
		save_data.close()


func _on_ResetButton_pressed():
	Global.score = 0
	get_tree().reload_current_scene()


func _on_ExtitToMenuButton_pressed():
	get_tree().set_deferred("paused", false)
	get_tree().change_scene("res://Main.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_Result_visibility_changed():
	var s = str(Global.score)
	var n = 5 - s.length()
	$Panel/CurrentScore.text = "Your score: "
	while n > 0:
		$Panel/CurrentScore.text += '0'
		n -= 1
	$Panel/CurrentScore.text += s
	
	if Global.score > highscore:
		highscore = Global.score
		save_highscore()
	
	var hs = str(highscore)
	var n_hs = 5 - hs.length()
	$Panel/HighScore.text = "Highscore: "
	while n_hs > 0:
		$Panel/HighScore.text += '0'
		n_hs -= 1
	$Panel/HighScore.text += hs
