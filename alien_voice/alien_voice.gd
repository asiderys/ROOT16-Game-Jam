extends AudioStreamPlayer2D

func _ready() -> void:
	randomize()
func speak(duration):
	for i in range(floor(len(duration) / 4)):
		var rand = randi() % 15
		self.stream = load("res://AlienSounds/aliensound" + str(rand) + ".wav")
		self.play()
		await self.finished
