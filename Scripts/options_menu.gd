extends Node

@onready var options_manager: Control = $OptionsManager
@onready var sound_manager: Control = $SoundManager
@onready var controls_manager: Control = $ControlsManager
@onready var credits_manager: Control = $CreditsManager
@onready var back_5: TextureButton = $back5
		

func _on_sound_pressed() -> void:
	options_manager.visible =  false
	back_5.visible = false
	sound_manager.visible = true

func _on_controls_pressed() -> void:
	options_manager.visible =  false
	back_5.visible = false
	controls_manager.visible = true

func _on_credits_pressed() -> void:
	options_manager.visible = false
	back_5.visible = false
	credits_manager.visible = true

func _on_back_3_pressed() -> void:
	options_manager.visible =  true
	back_5.visible = true
	credits_manager.visible = false
	
func _on_back_2_pressed() -> void:
	options_manager.visible = true
	back_5.visible = true
	controls_manager.visible = false

func _on_back_pressed() -> void:
	options_manager.visible =  true
	back_5.visible = true
	sound_manager.visible = false
