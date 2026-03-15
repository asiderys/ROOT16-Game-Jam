extends Control

func _ready() -> void:
	$SpaceshipSelectionMusic.seek(global.music_pos)
	$SpaceshipSelectionMusic.play()
var colors = ["#FF0000", "#E57A10", "#FFFF00", "#00FF00", "#0000FF", "#FF00FF"]
var current_hue = 0
func next_sprite():
	current_hue = (current_hue + 1) % len(colors)
	$SelectedVBox/SelectedHBox/Selected.set_modulate(colors[current_hue])
func prev_sprite():
	current_hue = (current_hue - 1) % len(colors)
	$SelectedVBox/SelectedHBox/Selected.set_modulate(colors[current_hue])


func _on_continue_btn_pressed() -> void:
	global.music_pos = $CharacterSelectionMusic.get_playback_position()
	get_tree().change_scene_to_file("res://spaceship_selection/spaceship_selection.tscn")
