extends CanvasLayer

@onready var transition = get_node("inicial transition/ColorRect")
@onready var animation = get_node("inicial transition/ColorRect/AnimationPlayer")
@onready var inicial_transition: CanvasLayer = $"inicial transition"


func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
	animation.play("transition_out")
	
	await animation.animation_finished
	inicial_transition.hide()
func _on_start_pressed() -> void:
	await get_tree().create_timer(1.0).timeout
	inicial_transition.show()
	animation.play("transition_in")
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	await animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")
func _on_quit_pressed() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().quit()
func _on_options_pressed() -> void:
	pass #Botão de menu vai aqui
