extends Control

var amount_purchase = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Amount.text = str(amount_purchase)


func decrease_purchase_amount() -> void:
	amount_purchase = clamp(amount_purchase - 1, 0,INF)




func increase_purchase_amount() -> void:
	amount_purchase = clamp(amount_purchase + 1, 0,INF)
