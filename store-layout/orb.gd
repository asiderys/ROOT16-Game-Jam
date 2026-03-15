extends Node2D

var itemPurchase: product_data = null

@export var npcFrames: SpriteFrames:
	set(val):
		npcFrames = val
		if is_node_ready():
			$AnimatedSprite2D.sprite_frames = val

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var randNum = randi_range(0, global.maxProductTrust)
	for item in global.store_stock:
		if global.trust_vals[item.id] >= randNum and global.store_stock[item] > 0:
			itemPurchase = item
			break
	if itemPurchase != null:
		global.store_stock[itemPurchase] -= 1
		global.money += itemPurchase.sell_price
	if npcFrames:
		$AnimatedSprite2D.sprite_frames = npcFrames
		$AnimatedSprite2D.play("motion")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
