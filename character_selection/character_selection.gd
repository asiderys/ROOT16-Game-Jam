extends Control

func select_character(button):
	global.player_sprite = button.texture_normal
func _ready() -> void:
	for button in $CharacterBox.get_children():
		button.pressed.connect(select_character.bind(button))
	print($CharacterBox/TextureButton.texture_normal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
