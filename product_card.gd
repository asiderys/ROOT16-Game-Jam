extends Control
const product_data = preload("res://product_data.gd")
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

func decrease_purchase_amount() -> void:
	amount_purchase = clamp(amount_purchase - 1, 0,INF)

func increase_purchase_amount() -> void:
	amount_purchase = clamp(amount_purchase + 1, 0,INF)
