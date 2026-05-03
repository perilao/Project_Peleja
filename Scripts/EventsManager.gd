extends StaticBody3D

#TIMER PROPERTIES
@export var event_time := 4.0
@onready var timer_geral: Timer = $timer_geral
var original_wait_time: float
#EVENT
@export var event_name : String = ""
@onready var event = get_tree().get_nodes_in_group("event")
#PLAYER
@onready var player: CharacterBody3D = $"../../Player"
var isOnArea = false

#OUTLINE SHADERS
@onready var mesh: MeshInstance3D = $MeshInstance3D
@export var outline_material: Material
var Event_Color: Color
var hasPrinted = false


func _ready() -> void:
	Event_Color = mesh.get_active_material(0).albedo_color
	hasPrinted = false
	isOnArea = false
	if timer_geral.is_in_group("start_opened"):
		original_wait_time = timer_geral.wait_time
		timer_geral.wait_time = event_time
		timer_geral.start() 
func _process(_delta):
#CONTADOR
	#CHANGE STATE AFTER CERTAIN TIME
	if timer_geral.time_left <= event_time and hasPrinted == false:
		mesh.get_active_material(0).albedo_color = Color.RED
		print("Faltam ", event_time, " segundos!", event_name)
		hasPrinted = true
	#INTERACTION OBJECT/EVENT
	if Input.is_action_just_pressed("ui_interact"):
		if timer_geral.time_left <= event_time and isOnArea: 
			var object = player.hold_object
			if object != null and object.is_in_group("pickable"):
				if object.item_type == self.event_name:
					timer_geral.wait_time = original_wait_time
					timer_geral.start()
					object.use_item()
					player.release_object(true)
					mesh.get_active_material(0).albedo_color = Event_Color
					print("Sucesso! Porta ", event_name, " resetada.")
					hasPrinted = false
				else:
					print("Item errado! Você tem '", object.item_type, "' mas esta porta precisa de '", event_name, "'")
func _on_timer_geral_timeout() -> void:
	#PLAYER DEFEAT LOGIC
	get_tree().change_scene_to_file("res://Scenes/lose_screen.tscn")
#AREAS
func _on_area_3d_area_entered(_area: Area3D) -> void:
	isOnArea = true
	#mesh.material_override = outline_material
func _on_area_3d_area_exited(_area: Area3D) -> void:
	isOnArea = false
	#mesh.material_override = null
