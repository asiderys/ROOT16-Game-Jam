extends Control
@onready var product_card_scene = preload("res://product_card.tscn")
const product_data = preload("res://product_data.gd")

func setup(data: product_data):
	var product_card = product_card_scene.instantiate()
	product_card.self_data = data
	$Layout/ScrollBox/ProductCardContainer.add_child(product_card)
