extends Node2D

var npcSpeed = 200
var pathFollow2D = 0
var testDict = {"Yellow": 1, "Orange": 0, "Pink": 1, "Green": 1}
const orbNPC = preload("res://store-layout/orb.tscn")

const EMPTY_BIN = preload("res://store-layout/empty_bin.tscn")
const YELLOW = preload("res://store-layout/yellow_bin.tscn")
const ORANGE = preload("res://store-layout/orange_bin.tscn")
const PINK = preload("res://store-layout/pink_bin.tscn")
const GREEN = preload("res://store-layout/green_bin.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_npc()
	spawn_bins()

func spawn_npc():
	var path = get_node("Path2D")
	pathFollow2D = PathFollow2D.new()
	pathFollow2D.rotates = false
	path.add_child(pathFollow2D)
	var npc = orbNPC.instantiate()
	pathFollow2D.add_child(npc)
	var remote = RemoteTransform2D.new()
	pathFollow2D.add_child(remote)
	remote.remote_path = npc.get_path()

func spawn_bins():
	for bin in testDict:
		var bin_t = 0;
		if bin == "Yellow":
			if testDict[bin]:
				bin_t = YELLOW.instantiate()
			else:
				bin_t = EMPTY_BIN.instantiate()
			bin_t.global_position = $YellowMarker.global_position 
			add_child(bin_t)
		elif bin == "Orange":
			if testDict[bin]:
				bin_t = ORANGE.instantiate()
			else:
				bin_t = EMPTY_BIN.instantiate()
			bin_t.global_position = $OrangeMarker.global_position 
			add_child(bin_t)
		elif bin == "Pink":
			if testDict[bin]:
				bin_t = PINK.instantiate()
			else:
				bin_t = EMPTY_BIN.instantiate()
			bin_t.global_position = $PinkMarker.global_position 
			add_child(bin_t)
		elif bin == "Green":
			if testDict[bin]:
				bin_t = GREEN.instantiate()
			else:
				bin_t = EMPTY_BIN.instantiate()
			bin_t.global_position = $GreenMarker.global_position 
			add_child(bin_t)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pathFollow2D:
		pathFollow2D.progress += npcSpeed * delta
