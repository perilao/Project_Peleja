extends StaticBody3D

@export var event_time := 4.0
@onready var timer_geral: Timer = $timer_geral
@export var event_name : String = ""
@onready var player: CharacterBody3D = $"../../Player"
@onready var event = get_tree().get_nodes_in_group("event")
var hasPrinted = false
var isOnArea = false

func _ready() -> void:
	hasPrinted = false
	isOnArea = false
func _process(_delta):
#CONTADOR
	if timer_geral.time_left <= event_time and hasPrinted == false: #TROCA DE ESTADO DEPOIS DE CERTO TEMPO
		print("Faltam ", event_time, " segundos!", event_name)
		hasPrinted = true
	if Input.is_action_just_pressed("ui_interact"):
		if timer_geral.time_left <= event_time and isOnArea: 
			var object = player.hold_object
			if object != null and object.is_in_group("pickable"):
				if object.item_type == self.event_name:
					timer_geral.start()
					player.release_object()
					print("Sucesso! Porta ", event_name, " resetada.")
					hasPrinted = false
				else:
					print("Item errado! Você tem '", object.item_type, "' mas esta porta precisa de '", event_name, "'")
func _on_timer_geral_timeout() -> void: #DERROTA DO PLAYER
	get_tree().quit() 
func _on_area_3d_area_entered(_area: Area3D) -> void:
	isOnArea = true
func _on_area_3d_area_exited(_area: Area3D) -> void:
	isOnArea = false
