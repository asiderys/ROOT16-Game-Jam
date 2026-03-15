extends Node2D

var bubbleInstance = 0
var isWaiting: bool = false
var hasNotWaited: Array = [1, 1]
var stopPoints: Array = [600, 1100]
var stopTime: float = 6.0
var npc = 0
var npcSpeed = 200
var pathFollow2D = 0
var testDict = {"empty": 1,"xorp": 1, "zorp": 0, "dorp": 1, "morp": 1, "lorp":2, "torp":1, "shnorp": 1, "norp": 1}

var thoughtBubble = preload("res://store-layout/thoughtBubble.tscn")
const product_data = preload("res://restocking/product_data.gd")
const orbNPC = preload("res://store-layout/orb.tscn")

var npc_scene = preload("res://store-layout/orb.tscn")
var orb = preload("res://store-layout/aliens/orb.tres")

var npcTypes = [ 
	preload("res://store-layout/aliens/GOOMI.tres"), 
	preload("res://store-layout/aliens/jello.tres"), 
	preload("res://store-layout/aliens/orb.tres"), 
	preload("res://store-layout/aliens/PT.tres"), 
	preload("res://store-layout/aliens/sausage.tres"),
	preload("res://store-layout/aliens/Strange Steve.tres"),
	preload("res://store-layout/aliens/blorpl.tres") 
]

const EMPTY_BIN = preload("res://store-layout/empty_bin.tscn")
const YELLOW = preload("res://store-layout/yellow_bin.tscn")
const ORANGE = preload("res://store-layout/orange_bin.tscn")
const PINK = preload("res://store-layout/pink_bin.tscn")
const GREEN = preload("res://store-layout/green_bin.tscn")

const BUCKET_SCENE = preload("res://store-layout/bucket.tscn")

const NUM_NPCS = 5 # how many NPCs we want to spawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_bins()
	await get_tree().create_timer(5.0).timeout # just wait a few seconds before spawning any NPCs
	for i in range (NUM_NPCS):
		random_npc()
		await get_tree().create_timer(20.0).timeout 

func random_npc():
	# pick an alien, any alien...
	var randNPC = npcTypes.pick_random()
	# TODO: check if random NPC == currently selected character
	pathFollow2D = PathFollow2D.new()
	pathFollow2D.rotates = false
	pathFollow2D.set_script(preload("res://store-layout/npc_gen.gd")) 
	pathFollow2D.dialogueBox = get_node("DialogueBox")
	var npc = npc_scene.instantiate()
	npc.get_node("CharacterBody2D").input_pickable = true
	npc.get_node("CharacterBody2D").input_event.connect(pathFollow2D._on_input_event)
	
	var bubble = thoughtBubble.instantiate()
	bubble.name = "ThoughtBubble"
	bubble.visible = false
	bubble.position = Vector2(100, -150)
	npc.get_node("CharacterBody2D").add_child(bubble)
	
	pathFollow2D.add_child(npc)
	get_node("Path2D").add_child(pathFollow2D)
	# adding random sprite here instead of the green orb thing
	var randSprite = npc.get_node("CharacterBody2D/AnimatedSprite2D")
	randSprite.sprite_frames = randNPC
	
	#var remote = RemoteTransform2D.new()
	#pathFollow2D.add_child(remote)
	#remote.remote_path = npc.get_path()
	
func start_wait(loc, i):
	isWaiting = true
	pathFollow2D.progress = loc
	
	await get_tree().create_timer(stopTime).timeout
	
	isWaiting = false
	hasNotWaited[i] = false

func spawn_bins():
	# dictionary for strings (product name)

	var bin_scenes = {"Yellow": YELLOW, "Orange": ORANGE, "Pink": PINK, "Green": GREEN}
	var pos_index = 0
	var start_pos = Vector2(1113*1.66,327*1.66)
	var cur_pos = start_pos
	var diff = Vector2(-162*1.66, 150*1.66)
	for item in global.store_stock.keys():
		var bin = null
		#if(global.store_stock[item] == 0):
			#bin = "empty"
		var binInstance = 0
		binInstance = BUCKET_SCENE.instantiate()
		binInstance.change_type(item)
		#var marker = get_node(bin + "Marker") # wacky string manipulation, messy but works ig?
		if pos_index < (len(global.store_stock) / 2):
			cur_pos.x = (diff.x * (pos_index + 1)) + start_pos.x
			binInstance.position = cur_pos
		else:
			cur_pos.x = (diff.x * (pos_index - (len(global.store_stock)/2) + 1)) + start_pos.x
			cur_pos.y = start_pos.y + diff.y
			binInstance.position = cur_pos
		pos_index += 1
		add_child(binInstance)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if global.day < 3:
		global.day += 1
		get_tree().change_scene_to_file("res://restocking/Restocking.tscn")
	else:
		get_tree().change_scene_to_file("res://endings/endings.tscn")
