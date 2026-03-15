extends PathFollow2D

var npcSpeed = 200
var stopPoints = [600, 1100]
var stopTime = 3 # TODO: make different stop times for each 
var hasWaited = [true, true]
var isWaiting = false
var bubble = 0

var dialogueBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var npc = get_child(0)
	bubble = npc.get_node("CharacterBody2D/ThoughtBubble")
	
	#var body = npc.get_node("CharacterBody2D")
	#body.input_pickable = true
	#body.input_event.connect(_on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print(dialogueBox)
		if dialogueBox:
			dialogueBox.visible = !dialogueBox.visible
			if dialogueBox.visible:
				dialogueBox.updateDialogue()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var sprite = get_child(0).get_node("CharacterBody2D/AnimatedSprite2D")
	if progress_ratio > 0.98: # almost near the end
		queue_free() # should despawn just the alien 
		
	if not isWaiting:
		progress += npcSpeed * delta
		sprite.play("moving") # same name for all motion
		for i in range(stopPoints.size()):
			if abs(progress - stopPoints[i]) < 5 and hasWaited[i]: # picked a seemingly reaonable threshold
				startWait(i)
	else:
		sprite.stop()

func startWait(i):
	isWaiting = true
	hasWaited[i] = false
	if i == 0:
		bubble.visible = true
	
	await get_tree().create_timer(stopTime).timeout

	isWaiting = false
	bubble.visible = false
