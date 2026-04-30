extends Control


#@onready var transition = get_node("inicial transition/ColorRect")
#@onready var animation = get_node("inicial transition/ColorRect/AnimationPlayer")
#
#func _ready() -> void:
	#animation.play("transition_out")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
