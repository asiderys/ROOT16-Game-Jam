extends Control
const product_data = preload("res://restocking/product_data.gd")
var amount_purchase = 0
var self_data:product_data = null

func _ready() -> void:
	set_up_vals(self_data)

func _process(delta: float) -> void:
	$Amount.text = str(amount_purchase)
func set_up_vals(data: product_data):
	self_data = data
	$ItemName.text = data.item_name
	$StoreName.text = data.store_name
	$CoinsCount.text = str(data.cost)
	$TrustCount.text = str(data.trust_value)
	$ProfitCount.text = str(data.sell_price)
	$ItemIcon.texture = load("res://art/buckets/" + str(data.texture) + ".png")

func decrease_purchase_amount() -> void:
	$Decrement.play()
	if amount_purchase > 0:
		amount_purchase = amount_purchase - 1
		get_node("../../../..").update_total_cost(self_data.cost * -1)

func increase_purchase_amount() -> void:
	$Increment.play
	amount_purchase = amount_purchase + 1
	get_node("../../../..").update_total_cost(self_data.cost)
