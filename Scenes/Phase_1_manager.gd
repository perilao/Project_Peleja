extends Node3D

@onready var transition = get_node("inicial transition/ColorRect")
@onready var animation = get_node("inicial transition/ColorRect/AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("transition_out")
