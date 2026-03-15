extends Control

func _on_playbutton_pressed() -> void:
	$StartupSound.play()
	await $StartupSound.finished
	get_tree().change_scene_to_file("res://cutscene/cutscene.tscn")
