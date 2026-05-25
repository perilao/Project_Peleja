extends Node

#PLAYER
@onready var player: CharacterBody3D = $"../Player"
var player_in_exit := false
#EXIT BAR
@onready var progress_bar: ProgressBar = $ProgressBar
@export var second_stage = 0
@export var third_stage = 0
@export var fourth_stage = 0
#OUTLINE SHADERS
@export var mesh: MeshInstance3D
@export var outline_material: Material

func _ready() -> void:
	SoundControl.exit_remove.play()
func _process(_delta: float) -> void:
	#RETURN IF THE BAR IS QUEUE_FREE()
	if progress_bar == null:
		return
#PROGRESS BAR LOGIC
	#INCREASES THE BAR PROGRESS AND BLOCK PLAYER_INPUT
	if player_in_exit:
		if Input.is_action_pressed("ui_interact"):
			progress_bar.value += 1
			player.block_input = true
			SoundControl.exit_remove.play()
		#STOP THE BAR PROGRESS
		if Input.is_action_just_released("ui_interact"):
			SoundControl.exit_remove.stop()
			player.block_input = false
			if progress_bar.value < progress_bar.max_value:
				if progress_bar.value >= fourth_stage:
					progress_bar.value = fourth_stage
				elif progress_bar.value >= third_stage:
					progress_bar.value = third_stage
				elif progress_bar.value >= second_stage:
					progress_bar.value = second_stage
				else:
					progress_bar.value = progress_bar.min_value
		if progress_bar.value >= progress_bar.max_value:
			progress_bar_finished()

func progress_bar_finished():
	#TRIGGER THE EXIT FINAL
	LevelCore.lvl1_completed = true
	progress_bar.value = progress_bar.max_value
	player.block_input = false
	SoundControl.lvl_1_bgm.stop()
	get_tree().change_scene_to_file("res://Scenes/G.U.I/lvl_selector.tscn")
	
#AREA ENTERED
func _on_exit_door_area_body_entered(area: Area3D) -> void:
	player_in_exit = true
	if area == player.player_area:
		mesh.material_overlay = outline_material
func _on_exit_door_area_body_exited(area: Area3D) -> void:
	if area == player.player_area:
		mesh.material_overlay = null
