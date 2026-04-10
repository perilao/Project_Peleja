extends RigidBody3D

@export var item_type: String = ""
@export var uses: int = 3

@onready var label: Label3D = get_node_or_null("Label3D")


func _ready():
	update_label()


func use_item():
	if uses <= 0:
		return

	uses -= 1
	update_label()

	print("Usos:", uses)

	if uses <= 0:
		#não destrói imediatamente
		await get_tree().process_frame
		queue_free()


func update_label():
	if label != null:
		label.text = str(uses)
