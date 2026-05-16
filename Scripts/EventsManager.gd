extends StaticBody3D

#TIMER PROPERTIES
@export var event_time := 4.0
@export var event_dangerous := 15.0
@export var event_broken := 40.0
@onready var timer_geral: Timer = $timer_geral
var original_wait_time: float
#EVENT
@export var event_name : String = ""
@onready var event = get_tree().get_nodes_in_group("event")
var current_state := ""
#PLAYER
@onready var player: CharacterBody3D = $"../../Player"
var isOnArea = false

#OUTLINE SHADERS
@onready var mesh: MeshInstance3D = $MeshInstance3D
@export var outline_material: Material
var Event_Color: Color
#ANIMATION CONTROLLER
@export var animation_player: AnimationPlayer


func _ready() -> void:
	Event_Color = mesh.get_active_material(0).albedo_color
	animation_player.play("blocked")
	isOnArea = false
	SoundControl.item_break.stop()
	if timer_geral.is_in_group("start_opened"):
		original_wait_time = timer_geral.wait_time
		timer_geral.wait_time = event_time
		timer_geral.start() 
func _process(_delta):
#CONTADOR
	#CHANGE STATE AFTER CERTAIN TIME
	#3 SEGUNDOS ANTES DO JOGADOR PERDER
	if timer_geral.time_left <= event_time and timer_geral.time_left < event_dangerous:
		if current_state != "open_dangerous":
			current_state = "open_dangerous"
			if animation_player and animation_player.current_animation != "open_dangerous":
				animation_player.play("open_dangerous") 
				SoundControl.lose.play()
	#QUANDO A ENTRADA FICA LIVRE
	elif timer_geral.time_left <= event_time:
		if current_state != "open":
			current_state = "open"
			if animation_player and animation_player.current_animation != "open":
				animation_player.play("open")
				SoundControl.item_break.play()
	#QUANDO A BARRICADA SE QUEBRA
	elif timer_geral.time_left >= event_time and timer_geral.time_left < event_broken:
		if current_state != "broken":
			current_state = "broken"
			if animation_player and animation_player.current_animation != "broken":
				animation_player.play("broken") 
				SoundControl.item_break.play()

	#INTERACTION OBJECT/EVENT
	if Input.is_action_just_pressed("ui_interact"):
		if timer_geral.time_left <= event_time and isOnArea: 
			var object = player.hold_object
			if object != null and object.is_in_group("pickable"):
				if object.item_type == self.event_name:
					timer_geral.wait_time = original_wait_time
					timer_geral.start()
					object.use_item()
					print("Resetado!")
					player.release_object(true)
					mesh.get_active_material(0).albedo_color = Event_Color
					if current_state != "blocked":
						current_state = "blocked"
						if animation_player:
							animation_player.play("blocked")
				else:
					print("Item errado! Você tem '", object.item_type, "' mas esta porta precisa de '", event_name, "'")
func _on_timer_geral_timeout() -> void:
	#PLAYER DEFEAT LOGIC 
	SoundControl.lvl_1_bgm.stop()
	get_tree().change_scene_to_file("res://Scenes/lose_screen.tscn")
#AREAS
func _on_area_3d_area_entered(area: Area3D) -> void:
	if area == player.player_area:
		isOnArea = true
func _on_area_3d_area_exited(area: Area3D) -> void:
	if area == player.player_area:
		isOnArea = false
