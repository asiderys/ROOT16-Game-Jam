extends Control

func select_character(button):
	global.player_sprite = button.texture_normal
func _ready() -> void:
	for button in $CharacterBox.get_children():
		button.pressed.connect(select_character.bind(button))
