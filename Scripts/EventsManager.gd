extends StaticBody3D

@export var event_time := 4.0
@onready var timer_geral: Timer = $timer_geral
@export var event_name : String = ""
@onready var player: CharacterBody3D = $"../../Player"

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
	if Input.is_action_just_pressed("ui_interact") and timer_geral.time_left <= event_time and isOnArea == true and player.player_has_item == true: #AÇÃO DO ITEM
		timer_geral.start()
		player.release_object()
		if timer_geral.time_left == timer_geral.wait_time:
			print("Timer Resetado")
			hasPrinted = false 
func _on_timer_geral_timeout() -> void: #DERROTA DO PLAYER
		get_tree().quit() 
func _on_area_3d_area_entered(area: Area3D) -> void:
	#print("Area ENTERED!")
	isOnArea = true
func _on_area_3d_area_exited(area: Area3D) -> void:
	#print("Area EXITED!")
	isOnArea = false
