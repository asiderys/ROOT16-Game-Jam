extends Control

var aliens = [
	"blorpl",
	"bello_jello",
	"goomi_gami",
	"orb",
	"PT",
	"sausage",
	"SPHEEP",
	"strange_steve"
]
var current_alien = 0
func _ready() -> void:
	$SelectedVBox/SelectedHBox/Selected.sprite_frames = load("res://art/aliens/" + aliens[current_alien] + "/" + aliens[current_alien] + "_frames.tres")
	$SelectedVBox/SelectedHBox/Selected.play()
func next_sprite():
	$DefaultButton.play()
	current_alien = (current_alien + 1) % len(aliens)
	$SelectedVBox/SelectedHBox/Selected.sprite_frames = load("res://art/aliens/" + aliens[current_alien] + "/" + aliens[current_alien] + "_frames.tres")
	$SelectedVBox/SelectedHBox/Selected.play()
	global.player_sprite = $SelectedVBox/SelectedHBox/Selected.sprite_frames
func prev_sprite():
	$DefaultButton.play()
	current_alien = (current_alien - 1) % len(aliens)
	$SelectedVBox/SelectedHBox/Selected.sprite_frames = load("res://art/aliens/" + aliens[current_alien] + "/" + aliens[current_alien] + "_frames.tres")
	$SelectedVBox/SelectedHBox/Selected.play()
	global.player_sprite = $SelectedVBox/SelectedHBox/Selected.sprite_frames


func _on_continue_btn_pressed() -> void:
	$ChooseCharacter.play()
	await $ChooseCharacter.finished
	global.music_pos = $CharacterSelectionMusic.get_playback_position()
	get_tree().change_scene_to_file("res://spaceship_selection/spaceship_selection.tscn")
