extends CharacterBody2D

var tileSize = 32 # can change this later just picked one for now
var animation_speed = 3
var moving = false
var inputs = {"ui_right": Vector2.RIGHT, 
"ui_left": Vector2.LEFT, 
"ui_up": Vector2.UP, 
"ui_down": Vector2.DOWN}

@onready var ray = $RayCast2D
@onready var anim = $AnimatedSprite2D
@export var speed = 300

const EMPTY_BIN = preload("res://store-layout/empty_bin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = position.snapped(Vector2.ONE * tileSize)
	position += Vector2.ONE * tileSize/2
	$AnimatedSprite2D.sprite_frames = load("res://art/aliens/" + global.player_sprite + "/" + global.player_sprite + "_frames.tres")
	
func get_input() -> Vector2:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	return input_direction

func _physics_process(delta):
	var input_direction = get_input()
	if input_direction != Vector2.ZERO:
		anim.play()
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
