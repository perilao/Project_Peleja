extends Node2D

@onready var next: TextureButton = $next
@onready var next_2: TextureButton = $next2
@onready var next_3: TextureButton = $next3
@onready var next_4: TextureButton = $next4

func _on_next_pressed() -> void:
	SoundControl.button_click.play()
	next.visible = false
	next_2.visible = true

func _on_next_2_pressed() -> void:
	SoundControl.button_click.play()
	next_2.visible = false
	next_3.visible = true

func _on_next_3_pressed() -> void:
	SoundControl.button_click.play()
	next_3.visible = false
	next_4.visible = true

func _on_next_4_pressed() -> void:
	SoundControl.button_click.play()
	get_tree().change_scene_to_file("res://Scenes/G.U.I/lvl_selector.tscn")
