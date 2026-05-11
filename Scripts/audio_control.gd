extends Control

@onready var options_manager: Control = $"../OptionsManager"
@onready var sound_manager: Control = $"."

func _ready():
	$VBoxContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_master_slider_mouse_exited() -> void:
	release_focus()

func _on_music_slider_mouse_exited() -> void:
	release_focus()

func _on_sfx_slider_mouse_exited() -> void:
	release_focus()

func _on_save_pressed() -> void:
	AudioServer.set_bus_volume_db(0,linear_to_db($VBoxContainer/MasterSlider.value))
	AudioServer.set_bus_volume_db(1,linear_to_db($VBoxContainer/MusicSlider.value))
	AudioServer.set_bus_volume_db(2,linear_to_db($VBoxContainer/SFXSlider.value))
