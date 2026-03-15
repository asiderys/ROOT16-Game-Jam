extends Node2D

@onready var dialogueBox = $Label

var dialogueOptions = {
	#"negative": "hello",
	"positive": [
		"I found everything I need, thank you!", 
		"Your store is awesome! Keep up the good work!",
		"Hi! My name is Sneep, and my family and I are so happy that you came to our planet. Thanks for talking to me, and I’ll definitely be back!",
		"Great store! Talking to customers means a lot and helps build great relationships."
	]
}
func updateDialogue():
	dialogueBox.text = dialogueOptions["positive"].pick_random()
	self.show()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
