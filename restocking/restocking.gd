extends Control
@onready var product_card_scene = preload("res://restocking/product_card.tscn")
const product_data = preload("res://restocking/product_data.gd")
var total_cost = 0
var bucket_num = 8
var products = [
	["Zorp", "zorp", "Super store", 300, "", 10],
	["Dorp", "dorp", "Super store", 150, "", 5],
	["Morp", "morp", "Super store", 220, "", 7],
	["Lorp", "lorp", "Super store", 70, "", 2],
	["Norp", "norp", "Super store", 200, "", 6],
	["Shnorp", "shnorp", "Super store", 280, "", 9],
	["Xorp", "xorp", "Super store", 120, "", 4],
	["Torp", "torp", "Super store", 90, "", 3],
]
func _ready() -> void:
	if global.store_stock.size() == 0:
		for item in products:
			var data = product_data.new()
			data.cost = item[3]
			data.item_name = item[1]
			data.sell_price = data.cost * 1.2
			data.trust_value = 0
			data.store_name = item[2]
			data.id = item[1]
			data.texture = item[1]
			global.store_stock[data] = 0
			global.trust_vals[data.id] = 0
	for item in global.store_stock:
		setup(item)
	$AnimationPlayer/HBoxContainer/Money.text = "Money: " + str(global.money)
func setup(data: product_data):
	var product_card = product_card_scene.instantiate()
	product_card.self_data = data
	$Layout/ScrollBox/ProductCardContainer.add_child(product_card)

func update_total_cost(update_val):
	total_cost += update_val
	$AnimationPlayer/HBoxContainer/CurrentCost.text = "Current cost: " + str(total_cost)
func submit_purchase() -> void:
	
	$DefaultButton.play() 
	if global.money >= total_cost:
		$Control/Button.visible = false 
		for product in $Layout/ScrollBox/ProductCardContainer.get_children():
			global.store_stock[product.self_data] = product.amount_purchase
		global.money -= total_cost
		get_tree().change_scene_to_file("res://store-layout/day_store.tscn")
	else:
		$AnimationPlayer.play("PurchaseError")
