extends CharacterBody3D 

# VARIAVEIS
@export var SPEED = 5.0
@export var ROTATION_SPEED = 10.0

@onready var item_2_rb: RigidBody3D = %item2_rb
@onready var player_raycast: ShapeCast3D = $Look
@onready var hand: Node3D = $Hand
@onready var player_area: Area3D = $Area3DPlayer

var hold_object: Node3D = null
var original_layer = 1
var player_has_item = false
var original_position: Vector3
var original_rotation: Vector3
var block_input := false


func _physics_process(delta: float) -> void:
	if block_input:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	player_movement(delta)
	if Input.is_action_just_pressed("ui_grab"):
		if hold_object:
			release_object()
		else:
			if player_raycast.is_colliding():
				var object = player_raycast.get_collider(0)
				if object.is_in_group("pickable"):
					grab_object(object)
	# SEGURAR OBJETO NA MÃO
	if hold_object:
		hold_object.global_position = hand.global_position
		hold_object.global_rotation = hand.global_rotation
	move_and_slide()
func grab_object(obj):
	hold_object = obj
	original_position = hold_object.global_position
	original_rotation = hold_object.global_rotation
	original_layer = obj.collision_layer
	obj.collision_layer = 2
	if obj.has_method("lock_move_z"):
		obj.lock_move_z()
	if hold_object is RigidBody3D:
		hold_object.freeze = true
	player_has_item = true

func player_movement(delta):
	#BLOCK INPUT
	if block_input:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		return
	# INPUT E DIREÇÃO
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	# MOVIMENTAÇÃO
	if direction.length() > 0:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	# ROTAÇÃO
		var target_angle = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, ROTATION_SPEED * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func release_object(consumed: bool = false):
	if hold_object:
		var obj = hold_object
		if !consumed:
			if obj.has_method("return_use") and obj.was_used:
				obj.return_use()
		else:
			obj.was_used = false
		obj.global_position = original_position 
		obj.global_rotation = original_rotation
		obj.collision_layer = original_layer
		if obj.has_method("release_move_z"):
			obj.release_move_z()
		if obj is RigidBody3D:
			obj.freeze = false
		
		player_has_item = false
		hold_object = null 
		
		if consumed and obj.uses <= 0:
			await get_tree().process_frame
			obj.queue_free()

func collect_item(obj):
	print("Item coletado!")
	obj.queue_free()
