extends CanvasLayer

@onready var button_manager: Control = $"Button Manager"
@onready var options_menu: Node = $"options menu"
@onready var back_5: TextureButton = $back5


func _ready() -> void:
	SoundControl.menu_bgm.play()
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	get_tree().paused = false

func _on_start_pressed() -> void:
	SoundControl.button_click.play()
	SoundControl.menu_bgm.stop()
	get_tree().change_scene_to_file("res://Scenes/G.U.I/lvl_selector.tscn")
	
func _on_quit_pressed() -> void:
	SoundControl.button_click.play()
	SoundControl.menu_bgm.stop()
	get_tree().quit()
	
func _on_options_pressed() -> void:
	SoundControl.button_click.play()
	button_manager.visible = false
	back_5.visible = true
	options_menu.visible = true
	
func _on_back_5_pressed() -> void:
	SoundControl.button_click.play()
	button_manager.visible = true
	back_5.visible = false
	options_menu.visible = false
