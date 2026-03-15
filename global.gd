extends Node

var day = 1
var store_stock = {}
var trust_vals = {}
var money = 700
var maxProductTrust = 0
var player_sprite = null

var suggestions = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
var music_pos = 0
var trust = 0
var profits = 0
var buckets_data = {
	1: {
		"name":"Zorp 1",
		"cost": 10.0,
		"profit": 15.0,
		"trust": 5
	},
		2: {
		"name":"Zorp 2",
		"cost": 10.0,
		"profit": 15.0,
		"trust": 5
	},
		3: {
		"name":"Zorp 3",
		"cost": 10.0,
		"profit": 15.0,
		"trust": 5
	},
		4: {
		"name":"Zorp 4",
		"cost": 10.0,
		"profit": 15.0,
		"trust": 5
	},
		5: {
		"name":"Zorp 5",
		"cost": 10.0,
		"profit": 15.0,
		"trust": 5
	},
		6: {
		"name":"Zorp 6",
		"cost": 10.0,
		"profit": 15.0,
		"trust": 5
	},
		7: {
		"name":"Zorp 7",
		"cost": 10.0,
		"profit": 15.0,
		"trust": 5
	},
		8: {
		"name":"Zorp 1",
		"cost": 10.0,
		"profit": 15.0,
		"trust": 5
	}
}
