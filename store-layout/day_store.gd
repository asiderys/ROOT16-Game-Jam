extends Node2D

var testDict = {"Yellow": 1, "Orange": 0, "Pink": 1, "Green": 1}

const EMPTY_BIN = preload("res://store-layout/empty_bin.tscn")
const YELLOW = preload("res://store-layout/yellow_bin.tscn")
const ORANGE = preload("res://store-layout/orange_bin.tscn")
const PINK = preload("res://store-layout/pink_bin.tscn")
const GREEN = preload("res://store-layout/green_bin.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_bins();

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
	pass
