extends Control
@onready var product_card_scene = preload("res://restocking/product_card.tscn")
const product_data = preload("res://restocking/product_data.gd")
var total_cost = 0
var bucket_num = 8
func _ready() -> void:
	for i in range(bucket_num):
		var data = product_data.new()
		data.cost = (randi() % 10) * 1
		data.item_name = "Item #" + str(i)
		data.sell_price = randi() % 20
		data.trust_value = randi() % 5
		data.store_name = "Store #" + str(randi() % 3)
		data.id = i + 1
		data.texture = i + 1
		setup(data)
func setup(data: product_data):
	var product_card = product_card_scene.instantiate()
	product_card.self_data = data
	$Layout/ScrollBox/ProductCardContainer.add_child(product_card)

func update_total_cost(update_val):
	total_cost += update_val
	$AnimationPlayer/HBoxContainer/CurrentCost.text = "Current cost: " + str(total_cost)
func submit_purchase() -> void:
	if global.money >= total_cost:
		for product in $Layout/ScrollBox/ProductCardContainer.get_children():
			global.store_stock[product.self_data] = product.amount_purchase
		global.money -= total_cost
		print("Money: " + str(global.money))
		for i in global.store_stock.keys():
			print(i.item_name + ": " + str(global.store_stock[i]))
	else:
		$AnimationPlayer.play("PurchaseError")
