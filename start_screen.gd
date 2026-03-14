extends Control

func _on_playbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://cutscene.tscn")
