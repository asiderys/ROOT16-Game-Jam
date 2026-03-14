extends Area2D

var tileSize = 64
var inputs = {"ui_right": Vector2.RIGHT, 
"ui_left": Vector2.LEFT, 
"ui_up": Vector2.UP, 
"ui_down": Vector2.DOWN}

@onready var ray = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2

func _unhandled_input(event: InputEvent) -> void:
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tileSize
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += inputs[dir] * tileSize
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
