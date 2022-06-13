extends Control


const SAVE_FILE_PATH = "user://savedata.save"

var highscore = 0


func _ready():
	$CharacterSelect.visible = false
	load_highscore()
	var s = str(highscore)
	var n = 5 - s.length()
	$TheBest.text = "The Best: "
	while n > 0:
		$TheBest.text += '0'
		n -= 1
	$TheBest.text += s


func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var()
		save_data.close()


func _on_StartButton_pressed():
	Global.score = 0
	$CharacterSelect.visible = true


func _on_QuitButton_pressed():
	get_tree().quit()
