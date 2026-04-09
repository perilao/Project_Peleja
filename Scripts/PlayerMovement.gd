extends CharacterBody3D
#VARIAVEIS
@export var SPEED = 5.0
@export var ROTATION_SPEED = 10.0
@onready var player_raycast: RayCast3D = $Look
@onready var hand: Node3D = $Hand
var hold_object: Node3D = null
var original_layer = 1
var player_has_item = false
var original_position: Vector3
var original_rotation: Vector3
@onready var player_area: Area3D = $Area3DPlayer



func _physics_process(delta: float) -> void:
#GRAVIDADE
	if not is_on_floor():
		velocity += get_gravity() * delta
#INPUT E DIRECAO
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
#MOVIMENTACAO
	if direction.length() > 0:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
#ROTACAO
		var target_angle = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, ROTATION_SPEED * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
#SEGURAR/SOLTAR OBJECTO
	if hold_object:
		hold_object.global_position = hand.global_position
		hold_object.global_rotation = hand.global_rotation
		if Input.is_action_just_pressed("ui_grab"):
			release_object()
	else:
		if player_raycast.is_colliding():
			var object = player_raycast.get_collider()
			if object.is_in_group("pickable"):
				if Input.is_action_just_pressed("ui_grab"):
					grab_object(object)
	move_and_slide()

func grab_object(obj):
	hold_object = obj
	original_position = hold_object.global_position
	original_rotation = hold_object.global_rotation
	original_layer = obj.collision_layer
	obj.collision_layer = 2
	if hold_object is RigidBody3D:
		hold_object.freeze = true
		player_has_item = true

func release_object():
	if hold_object:
		hold_object.global_position = original_position 
		hold_object.global_rotation = original_rotation
		hold_object.collision_layer = original_layer
		if hold_object is RigidBody3D:
			hold_object.freeze = false
			player_has_item = false
		hold_object = null
