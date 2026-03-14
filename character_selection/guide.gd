extends Control

func _ready() -> void:
	$GuideFrames.play()
	$AlienVoice.speak("Go ahead and choose your alien!")
