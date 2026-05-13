extends Control

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/G.U.I/lvl_selector.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/G.U.I/main_menu.tscn")
