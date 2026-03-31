extends StaticBody3D

@onready var timer_geral: Timer = $timer_geral
var hasPrinted = false
var isOnArea = false

func _ready() -> void:
	hasPrinted = false
	isOnArea = false

func _process(_delta):
	#print(timer_geral.time_left) #CONTADOR
	if timer_geral.time_left <= 4.0 and hasPrinted == false: #TROCA DE ESTADO DEPOIS DE CERTO TEMPO
		print("Faltam 4 segundos!")
		hasPrinted = true
	if Input.is_action_just_pressed("ui_grab") and timer_geral.time_left <= 4.0 and isOnArea == true: #AÇÃO DO ITEM
		timer_geral.start()
		if timer_geral.time_left == timer_geral.wait_time:
			print("Timer Resetado")
			hasPrinted = false
func _on_timer_geral_timeout() -> void: #DERROTA DO PLAYER
		get_tree().quit() 
func _on_area_3d_area_entered(area: Area3D) -> void:
	print("Area ENTERED!")
	isOnArea = true
func _on_area_3d_area_exited(area: Area3D) -> void:
	print("Area EXITED!")
	isOnArea = false
