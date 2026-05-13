extends Node2D

@onready var button: Button = %Button
@onready var button_2: Button = %Button2
@onready var button_3: Button = %Button3
@onready var playable_lvl_1: ColorRect = $Playable_lvl1
@onready var playable_lvl_2: ColorRect = $Playable_lvl2
@onready var locked_lvl_2: ColorRect = $Locked_lvl2
@onready var playable_lvl_3: ColorRect = $Playable_lvl3
@onready var locked_lvl_3: ColorRect = $Locked_lvl3
@onready var lock_lvl_2: Sprite2D = $Lock_lvl2
@onready var lock_lvl_3: Sprite2D = $Lock_lvl3


func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	
	if LevelCore.lvl1_completed == true:
		playable_lvl_1.visible = false
		lock_lvl_2.visible = false
		locked_lvl_2.visible = false
	if LevelCore.lvl1_completed == false:
		playable_lvl_1.visible = true
		lock_lvl_2.visible = true
		locked_lvl_2.visible = true
		
	if LevelCore.lvl2_completed == true:
		playable_lvl_2.visible = false
		lock_lvl_3.visible = false
		locked_lvl_3.visible = false
	if LevelCore.lvl2_completed == false:
		lock_lvl_3.visible = true
		locked_lvl_3.visible = true
		
	if LevelCore.lvl3_completed == true:
		playable_lvl_3.visible = false
		
#BUTTONS
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Current_Level1.tscn")
	
func _on_button_2_pressed() -> void:
	if LevelCore.lvl1_completed == true:
		get_tree().change_scene_to_file("res://Scenes/Backup_level.tscn")
	else:
		null
		
func _on_button_3_pressed() -> void:
	if LevelCore.lvl2_completed == true:
		get_tree().change_scene_to_file("res://LVL/lvl3.tscn")
	else:
		null

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/G.U.I/main_menu.tscn")
