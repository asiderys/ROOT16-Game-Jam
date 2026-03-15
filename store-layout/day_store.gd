extends Node2D

var isWaiting: bool = false
var hasNotWaited: Array = [1, 1]
var stopPoints: Array = [600, 1100]
var stopTime: float = 6.0
var npc = 0;
var npcSpeed = 200
var pathFollow2D = 0
var testDict = {"Yellow": 1, "Orange": 0, "Pink": 1, "Green": 1}
const orbNPC = preload("res://store-layout/orb.tscn")

var npc_scene = preload("res://store-layout/orb.tscn")
var orb = preload("res://store-layout/aliens/orb.tres")

var npcTypes = [ 
	preload("res://store-layout/aliens/GOOMI.tres"), 
	preload("res://store-layout/aliens/jello.tres"), 
	preload("res://store-layout/aliens/orb.tres"), 
	preload("res://store-layout/aliens/PT.tres"), 
	preload("res://store-layout/aliens/sausage.tres"),
	preload("res://store-layout/aliens/Strange Steve.tres") 
]

const EMPTY_BIN = preload("res://store-layout/empty_bin.tscn")
const YELLOW = preload("res://store-layout/yellow_bin.tscn")
const ORANGE = preload("res://store-layout/orange_bin.tscn")
const PINK = preload("res://store-layout/pink_bin.tscn")
const GREEN = preload("res://store-layout/green_bin.tscn")
const NUM_NPCS = 5 # how many NPCs we want to spawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn_npc(orb)
	spawn_bins()
	await get_tree().create_timer(5.0).timeout # just wait a few seconds before spawning any NPCs
	for i in range (NUM_NPCS):
		random_npc()
		await get_tree().create_timer(20.0).timeout 

func spawn_npc(frames):
	var path = get_node("Path2D")
	
	pathFollow2D = PathFollow2D.new()
	pathFollow2D.rotates = false
	pathFollow2D.loop = false
	path.add_child(pathFollow2D)
	npc = orbNPC.instantiate()
	pathFollow2D.add_child(npc)
	
	var sprite = npc.get_node("CharacterBody2D/AnimatedSprite2D")
	sprite.sprite_frames = frames
	sprite.play("motion")
	
	var remote = RemoteTransform2D.new()
	pathFollow2D.add_child(remote)
	remote.remote_path = npc.get_path()

func random_npc():
	var randNPC = npcTypes.pick_random()
	pathFollow2D = PathFollow2D.new()
	pathFollow2D.rotates = false
	var npc = npc_scene.instantiate()
	pathFollow2D.add_child(npc)
	get_node("Path2D").add_child(pathFollow2D)
	# adding random sprite here instead of the green orb thing
	var randSprite = npc.get_node("CharacterBody2D/AnimatedSprite2D")
	randSprite.sprite_frames = randNPC
	randSprite.play("motion")
	
	var remote = RemoteTransform2D.new()
	pathFollow2D.add_child(remote)
	remote.remote_path = npc.get_path()
	

func start_wait(loc, i):
	isWaiting = true
	pathFollow2D.progress = loc
	
	await get_tree().create_timer(stopTime).timeout
	
	isWaiting = false
	hasNotWaited[i] = false

func spawn_bins():
	
	var bin_scenes = {"Yellow": YELLOW, "Orange": ORANGE, "Pink": PINK, "Green": GREEN}
	
	for bin in testDict:
		var binInstance
		if testDict[bin] == 1:
			binInstance = bin_scenes[bin].instantiate()
		else:
			binInstance = EMPTY_BIN.instantiate()
		var marker = get_node(bin + "Marker") # wacky ahh string manipulation folks
		binInstance.global_position = marker.global_position
		add_child(binInstance)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pathFollow2D and not isWaiting:
		pathFollow2D.progress += npcSpeed * delta
		for i in range(stopPoints.size()):
			if abs(pathFollow2D.progress - stopPoints[i]) < 5.0 and hasNotWaited[i]: # some arbitrary threshold I picked
				start_wait(stopPoints[i], i)
