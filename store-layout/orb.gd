extends Node2D

@export var npcFrames: SpriteFrames:
	set(val):
		npcFrames = val
		if is_node_ready():
			$AnimatedSprite2D.sprite_frames = val

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if npcFrames:
		$AnimatedSprite2D.sprite_frames = npcFrames
		$AnimatedSprite2D.play("motion")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
