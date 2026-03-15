extends Control

func _ready() -> void:
	$SpaceshipSelectionMusic.seek(global.music_pos)
	$SpaceshipSelectionMusic.play()
var colors = ["#FF0000", "#E57A10", "#FFFF00", "#00FF00", "#0000FF", "#FF00FF"]
var current_hue = 0
func next_sprite():
	$DefaultButton.play()
	current_hue = (current_hue + 1) % len(colors)
	$SelectedVBox/SelectedHBox/Selected.set_modulate(colors[current_hue])
func prev_sprite():
	$DefaultButton.play()
	current_hue = (current_hue - 1) % len(colors)
	$SelectedVBox/SelectedHBox/Selected.set_modulate(colors[current_hue])


func _on_continue_btn_pressed() -> void:
	$SpaceshipSelect.play()
	await $SpaceshipSelect.finished
	# TODO: CHANGE SCENE
