extends Node
@onready var player: CharacterBody3D = $"../Player"
var player_in_exit := false
@onready var progress_bar: ProgressBar = $ProgressBar
@export var middle_bar = 0


func _process(_delta: float) -> void:
	if progress_bar == null:
		return
	if player_in_exit:
		if Input.is_action_pressed("ui_interact"):
			progress_bar.value += 1
			player.block_input = true
		if Input.is_action_just_released("ui_interact"):
			player.block_input = false
			if progress_bar.value < progress_bar.max_value:
				if progress_bar.value >= middle_bar and progress_bar.value <= progress_bar.max_value:
					progress_bar.value = middle_bar
				else:
					progress_bar.value = progress_bar.min_value
		if progress_bar.value == progress_bar.max_value:
			progress_bar_finished()

func progress_bar_finished():
	progress_bar.value = progress_bar.max_value
	print("Voce Conseguiu!")
	player.block_input = false
	get_tree().change_scene_to_file("res://Scenes/Win_Screen.tscn")
	#await get_tree().create_timer(1.0).timeout
	
	#if is_instance_valid(progress_bar):
		#progress_bar.queue_free()
		#progress_bar = null

func _on_exit_door_area_body_entered(_body: Node3D) -> void:
	player_in_exit = true
func _on_exit_door_area_body_exited(_body: Node3D) -> void:
	player_in_exit = false
