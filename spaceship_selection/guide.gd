extends Control
func _ready() -> void:
	$GuideFrames.play()
	$ColorRect/Label.text="Here is your spaceship with your mobile community store on board. This is how you will be traveling to each planet."
	$AlienVoice.speak("Here is your spaceship with your mobile community store on board. This is how you will be traveling to each planet.")
	await get_tree().create_timer(6).timeout
	$ColorRect/Label.text="Give your store a name and customize your spaceship color if you wish"
	$AlienVoice.speak("Give your store a name and customize your spaceship color if you wish")
	await get_tree().create_timer(4).timeout
	self.visible = false
