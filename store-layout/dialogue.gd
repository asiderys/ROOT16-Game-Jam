extends Node2D

@onready var dialogueBox = $Label



func updateDialogue():
	var randNum = randi_range(1, 10)
	var randItem: product_data = global.store_stock.keys().pick_random()
	var item = randItem.item_name
	var dialogueOptions = {
	"negative": ["I was looking for " + item + ", are you able to stock that in the future?",
		"I wanted products with a nutritional value better than " + item,
		"On more of a tight budget - is it possible to have items less expensive than " + item,
		"I want more high-quality items - can you stock things with more nutrition than " + item,
		"Your store sucks!"  
	],
	"positive": [
		"I found everything I need, thank you!", 
		"Your store is awesome! Keep up the good work!",
		"Hi! My name is Sneep, and my family and I are so happy that you came to our planet. Thanks for talking to me, and I’ll definitely be back!",
		"Great store! Talking to customers means a lot and helps build great relationships."
	]
}	

	if randNum > 7:
		dialogueBox.text = dialogueOptions["positive"].pick_random()
		global.trust += 10
	else:
		dialogueBox.text = dialogueOptions["negative"].pick_random()
		global.trust_vals[randItem.id] += 5
		if global.trust_vals[randItem.id] > global.maxProductTrust:
			global.maxProductTrust = global.trust_vals[randItem.id]
	self.show()
	global.suggestions.append(dialogueBox.text)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
