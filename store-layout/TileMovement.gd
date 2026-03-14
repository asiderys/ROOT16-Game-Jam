extends CharacterBody2D

var tileSize = 48
var inputs = {"ui_right": Vector2.RIGHT, 
"ui_left": Vector2.LEFT, 
"ui_up": Vector2.UP, 
"ui_down": Vector2.DOWN}

@onready var ray = $RayCast2D
@onready var anim = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2

func _unhandled_input(event: InputEvent) -> void:
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	var target = inputs[dir] * tileSize
	anim.play('move_anim')
	if not test_move(global_transform, target):
		position += target
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
