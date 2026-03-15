extends Node2D

var bucket_data = null
func change_type(data: product_data):
	bucket_data = data
	$StaticBody2D/Sprite2D.texture = load("res://art/buckets/" + data.texture + "_bucket.png")
	$ToolTip/Box/NameLbl.text = bucket_data.item_name
	$ToolTip/Box/SellPriceLbl.text = "Sell price: " + str(bucket_data.sell_price) + " $tars"
	$ToolTip/Box/DescrLbl.text = bucket_data.description

func _on_mouse_area_mouse_entered() -> void:
	$ToolTip.visible = true

func _on_mouse_area_mouse_exited() -> void:
	$ToolTip.visible = false
