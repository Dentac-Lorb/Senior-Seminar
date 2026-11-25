extends StaticBody2D
class_name Door

# Default to -1(All Channels). @export_flags gives checkboxes in the Inspector!
@export_flags("Channel 1", "Channel 2", "Channel 3", "Channel 4", "Channel 5") var channel : int = -1

@onready var collision_shape:CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect = $ColorRect
@export var sources: Array[Node]
@export var reset_on_cross: Array[Node]

var is_active: bool = false
var active_bodies: Array[Node] = []

func _ready() -> void:
	# Add this door to the global "doors" group
	add_to_group("doors")
	deactivate() # Start in closed / solid state
	for source in sources:
		if source.has_signal("update_targets"):
			source.connect("update_targets", update)
			
			
	var passthrough: Area2D = null
	if has_node("PassThroughArea"):
		passthrough = $PassThroughArea
	elif not reset_on_cross.is_empty():
		passthrough = Area2D.new()
		var passthrough_shape = CollisionShape2D.new()
		passthrough_shape.shape = collision_shape.shape
		passthrough.add_child(passthrough_shape)
		add_child(passthrough)
	
	if passthrough != null:
		passthrough.body_entered.connect(_on_pass_through_entered)
		passthrough.body_exited.connect(_on_pass_through_exited)
		#source_inputs[source] = source.default_output() if source.has_method("default_output") else 0

func update(node: Node, channel_mask: int, state: bool):
	if channel_mask & channel != 0:
		activate()
	else: deactivate()

func activate() -> void:
	is_active = true
	collision_shape.set_deferred("disabled", true)
	color_rect.modulate.a = 0.25 # Semi-transparent when active / open

func deactivate() -> void:
	is_active = false
	collision_shape.set_deferred("disabled", false)
	color_rect.modulate.a = 1.0 # Solid when deactivated / closed
	
# Checks if the incoming button channel matches this door using bitwise &
func matches_channel(trigger_channel: int) -> bool:
	if channel == -1 or trigger_channel == -1:
		return true
	return (channel & trigger_channel) != 0

func _on_pass_through_entered(body: Node) -> void:
	active_bodies.append(body)
	
func _on_pass_through_exited(body: Node) -> void:
	active_bodies.erase(body)
	if is_active and active_bodies.is_empty():
		#deactivate()
		for logic_source in reset_on_cross:
			if logic_source.has_method("reset"):
				logic_source.reset()
		#if linked_button and linked_button.has_method("reset_button"):
		#	linked_button.reset_button()
