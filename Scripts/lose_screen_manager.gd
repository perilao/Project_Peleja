extends Control

func _on_restart_pressed() -> void:
	SoundControl.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/G.U.I/main_menu.tscn")
