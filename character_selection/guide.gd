extends Control

func _ready() -> void:
	$GuideFrames.play()
	$AlienVoice.speak("Go ahead and choose your alien!")
	await get_tree().create_timer(4).timeout
	self.visible = false
