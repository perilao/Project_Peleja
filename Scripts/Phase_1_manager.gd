extends Node3D

@onready var pause_menu = $PauseMenuUI
var paused = false
@onready var music_level: AudioStreamPlayer3D = $"Audio/Music Level"
	 
func _ready() -> void:
	Engine.time_scale = 1
	get_tree().paused = false
	SoundControl.lvl_1_bgm.play()
	pause_menu.hide()
func _process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		PauseMenu()
func PauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1 
	if !paused:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
