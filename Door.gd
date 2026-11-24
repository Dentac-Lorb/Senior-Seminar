extends StaticBody2D

@export var linked_button: Area2D # Drag your ButtonTrigger node here in Inspector

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var visual: ColorRect = $ColorRect

var is_open: bool = false

func _ready() -> void:
	# Check if PassThroughArea exists as a child
	if has_node("PassThroughArea"):
		$PassThroughArea.body_exited.connect(_on_pass_through_exited)

func open_door() -> void:
	is_open = true
	collision.set_deferred("disabled", true)
	visual.modulate.a = 0.2

func close_door() -> void:
	is_open = false
	collision.set_deferred("disabled", false)
	visual.modulate.a = 1.0

func _on_pass_through_exited(body: Node) -> void:
	if is_open:
		close_door()
		if linked_button and linked_button.has_method("reset_button"):
			linked_button.reset_button()
