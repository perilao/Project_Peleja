extends Node2D

@onready var options_menu: Node2D = $"options menu"
@onready var pause_panel: Panel = $PausePanel
@onready var back_4: TextureButton = $back4

func _on_quit_pressed() -> void:
	SoundControl.button_click.play()
	get_tree().quit()

func _on_options_pressed() -> void:
	SoundControl.button_click.play()
	pause_panel.visible = false
	back_4.visible = true
	options_menu.visible = true

func _on_menu_pressed() -> void:
	SoundControl.button_click.play()
	SoundControl.lvl_1_bgm.stop()
	for child in SoundControl.get_children():
		if child is AudioStreamPlayer:
			child.stop()
	pause_panel = null
	back_4 = null
	options_menu = null
	get_tree().paused = false
	var main_menu_scene = load("res://Scenes/G.U.I/main_menu.tscn")
	get_tree().change_scene_to_packed(main_menu_scene)

func _on_back_4_pressed() -> void:
	SoundControl.button_click.play()
	pause_panel.visible = true
	back_4.visible = false
	options_menu.visible = false
