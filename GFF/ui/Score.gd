extends Label


func _ready():
#	load_highscore()
	pass


func _process(delta):
	var s = str(Global.score)
	var n = 5 - s.length()
	self.text = ""
	while n > 0:
		self.text += '0'
		n -= 1
	self.text += s
