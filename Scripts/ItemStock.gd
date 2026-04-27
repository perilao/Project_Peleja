extends RigidBody3D

@export var item_type: String = ""
@export var max_uses: int = 3
var uses: int = 3
var was_used := false

@onready var label: Label3D = get_node_or_null("Label3D")


func _ready():
	uses = max_uses
	update_label()

func use_item():
	if uses <= 0:
		return
	uses -= 1
	was_used = true
	update_label()
	print("Usos:", uses)

func return_use():
	uses += 1
	was_used = false
	update_label()
	print("Usos:", uses)

func update_label():
	if label != null:
		label.text = str(uses)
