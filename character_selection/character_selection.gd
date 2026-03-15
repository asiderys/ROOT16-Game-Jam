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
	current_alien = (current_alien + 1) % len(aliens)
	change_sprite()
func prev_sprite():
	current_alien = (current_alien - 1) % len(aliens)
	change_sprite()

func change_sprite():
	$DefaultButton.play()
	$SelectedVBox/SelectedHBox/Selected.sprite_frames = load("res://art/aliens/" + aliens[current_alien] + "/" + aliens[current_alien] + "_frames.tres")
	$SelectedVBox/SelectedHBox/Selected.play()
	global.player_sprite = $SelectedVBox/SelectedHBox/Selected.sprite_frames
	if "sausage" == aliens[current_alien]:
		$SelectedVBox/SelectedHBox/Selected.scale = Vector2(0.15, 0.15)
	elif "strange_steve" == aliens[current_alien]:
		$SelectedVBox/SelectedHBox/Selected.scale = Vector2(0.25, 0.25)
	else:
		$SelectedVBox/SelectedHBox/Selected.scale = Vector2(0.218, 0.218)
func _on_continue_btn_pressed() -> void:
	$ChooseCharacter.play()
	await $ChooseCharacter.finished
	global.music_pos = $CharacterSelectionMusic.get_playback_position()
	get_tree().change_scene_to_file("res://spaceship_selection/spaceship_selection.tscn")
