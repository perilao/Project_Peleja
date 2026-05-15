extends CharacterBody3D 

#PLAYER
@export var SPEED = 5.0
@export var ROTATION_SPEED = 10.0
@onready var hand: Node3D = $Hand
@onready var player_area: Area3D = $Area3DPlayer
@onready var player_raycast: ShapeCast3D = $Look
var lock_rotation := false
var locked_rotation_y: float
var lock_z := false
#ITEM GRAB
var player_has_item = false
var original_layer = 1
var original_position: Vector3
var original_rotation: Vector3
var cant_grab = false
#ITENS
@onready var item_2_rb: RigidBody3D = %item2_rb
var hold_object: Node3D = null
var block_input := false
var release_distance := 2.0
var hold_rotation_offset: Vector3
#AUDIO
@onready var walk_audio: AudioStreamPlayer3D = $"../Audio/Walk"
#ANIMATION
@onready var animation: AnimationPlayer = $"animações 3/AnimationPlayer"

func _ready() -> void:
	print("Player ready! Stack: ", get_stack())
	block_input = false
	lock_z = false
	lock_rotation = false
	locked_rotation_y = 0.0
func _physics_process(delta: float) -> void:
	#BLOCK PLAYER MOVEMENT
	if block_input:
		return
	#GET GRAVITY
	if not is_on_floor():
		velocity += get_gravity() * delta
	player_movement(delta)
	#GRAB OBJECT
	if Input.is_action_just_pressed("ui_grab"):
		if hold_object:
			if hold_object.is_in_group("movable"):
				var area: Area3D = null
				for child in hold_object.get_children():
					if child is Area3D:
						area = child
						break
				if area and area.get_overlapping_bodies().size() <= 1 and area.get_overlapping_areas().size() <= 1:
					release_object()
			else:
				var dist = global_position.distance_to(original_position)
				if dist <= release_distance:
					release_object()
		else:
			if player_raycast.is_colliding():
				var object = player_raycast.get_collider(0)
				if object.is_in_group("pickable") or object.is_in_group("movable"):
					grab_object(object)
				elif object.is_in_group("pushable") and cant_grab == false:
					object.start_push()
	if hold_object:
		if hold_object.is_in_group("movable"):
			var forward_offset = transform.basis.z * 1.3
			hold_object.global_position = global_position + forward_offset + Vector3(0, 0.5, 0)
			hold_object.global_rotation.y = rotation.y
		else:
			hold_object.global_position = hand.global_position
			hold_object.global_rotation = hand.global_rotation + hold_rotation_offset
	animation_controller()
	move_and_slide()

func grab_object(obj):
	hold_object = obj
	original_layer = obj.collision_layer
	obj.collision_layer = 2
	hold_rotation_offset = obj.global_rotation - hand.global_rotation
	SoundControl.item_grab.play()
	if obj.is_in_group("pushable"):
		obj.start_push()
		return
	if obj.is_in_group("movable"):
		if obj.has_method("set_held"):
			obj.set_held(true)
		original_rotation = hold_object.global_rotation
		var forward_offset = transform.basis.z * 1.3
		obj.global_position = global_position + forward_offset + Vector3(0, 0.5, 0)
	else:
		original_position = hold_object.global_position
		original_rotation = hold_object.global_rotation
	if obj.has_method("lock_move_z"):
		obj.lock_move_z()
	if hold_object is RigidBody3D:
		hold_object.freeze = false
	player_has_item = true

func player_movement(delta):
	#BLOCK INPUT
	if block_input:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		return
	#INPUT & DIRECTION
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	#MOVEMENT
	if lock_z:
		direction.z = 0.0
	if direction.length() > 0:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		#if !SoundControl.walk.playing:
			#SoundControl.walk.play()
		if !lock_rotation:
			var target_angle_ = atan2(direction.x, direction.z)
			rotation.y = lerp_angle(rotation.y, target_angle_, ROTATION_SPEED * delta)
		else:
			rotation.y = locked_rotation_y
	#PLAYER ROTATION
		var target_angle = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, ROTATION_SPEED * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func release_object(consumed: bool = false):
	#RELEASE OBJECT TRIGGER
	if hold_object:
		SoundControl.item_drop.play()
		var obj = hold_object
		if !consumed:
			if obj.has_method("return_use") and obj.was_used:
				obj.return_use()
			if obj.is_in_group("movable"):
				obj.collision_layer = original_layer
				if obj.has_method("set_held"): 
					obj.set_held(false)	
				player_has_item = false
				hold_object = null
				return 
			else:
				obj.global_position = original_position
				obj.global_rotation = original_rotation
		else:
			obj.was_used = false
		#RETURN OBJECT ORIGINAL POSITION
		obj.global_position = original_position
		obj.global_rotation = original_rotation
		obj.collision_layer = original_layer
		#RELEASE MOVEMENT IN Z POSITION
		if obj.has_method("release_move_z"):
			obj.release_move_z()
		if obj is RigidBody3D:
			obj.freeze = false
		player_has_item = false
		hold_object = null 
		#DELETES THE LAST ITEM
		if consumed and obj.uses <= 0:
			await get_tree().process_frame
			obj.queue_free()

func collect_item(obj):
	print("Item coletado!")
	obj.queue_free()

func animation_controller():
	if velocity.x or velocity.z != 0:
		if player_has_item:
			animation.play("grab_run")
		else:
			animation.play("run")
	else:
		if player_has_item:
			animation.play("idle_grab")
		else:
			animation.play("idle")
