extends CanvasLayer

@onready var transition = get_node("inicial transition/ColorRect")
@onready var animation = get_node("inicial transition/ColorRect/AnimationPlayer")
@onready var inicial_transition: CanvasLayer = $"inicial transition"
@onready var button_manager: Control = $"Button Manager"
@onready var options_menu: Node = $"options menu"
@onready var back_5: TextureButton = $back5


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
	get_tree().change_scene_to_file("res://Scenes/G.U.I/lvl_selector.tscn")
func _on_quit_pressed() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().quit()
func _on_options_pressed() -> void:
	button_manager.visible = false
	back_5.visible = true
	options_menu.visible = true
	
func _on_back_5_pressed() -> void:
	button_manager.visible = true
	back_5.visible = false
	options_menu.visible = false
