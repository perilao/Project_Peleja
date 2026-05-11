extends Node3D

@onready var transition = get_node("inicial transition/ColorRect")
@onready var animation = get_node("inicial transition/ColorRect/AnimationPlayer")
@onready var pause_menu = $PauseMenu
var paused = false
	 
func _process(delta):
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
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("transition_out")
	
