extends Node

@onready var options_manager: Control = $OptionsManager
@onready var sound_manager: Control = $SoundManager
@onready var controls_manager: Control = $ControlsManager
@onready var credits_manager: Control = $CreditsManager
@onready var back: TextureButton = $back

func _on_sound_pressed() -> void:
	options_manager.visible =  false
	sound_manager.visible = true
	back.visible = true

func _on_controls_pressed() -> void:
	options_manager.visible =  false
	controls_manager.visible = true
	back.visible = true

func _on_credits_pressed() -> void:
	options_manager.visible = false
	credits_manager.visible = true
	back.visible = true
	
func _on_back_pressed() -> void:
	options_manager.visible =  true
	sound_manager.visible = false
	controls_manager.visible = false
	credits_manager.visible = false
	back.visible = false
