extends Area2D
class_name ButtonTrigger

# Default to -1(All Channels). @export_flags gives checkboxes in the Inspector!
@export_flags("Channel 1", "Channel 2", "Channel 3", "Channel 4", "Channel 5") var channel : int = -1
#@export var connections: Array[Node]
@export var lock: bool
@onready var color_rect: ColorRect = $ColorRect

var active_bodies: Array[Node2D] = []

signal update_targets(node: Node, channel_mask: int, state: bool)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node2D) -> void:
	if not active_bodies.has(body):
		active_bodies.append(body)
	color_rect.color = Color.GREEN
	broadcast_state(true)
		
func _on_body_exited(body: Node2D) -> void:
	active_bodies.erase(body)
	# When all aprts of the fish have fully left:
	if active_bodies.is_empty():
		color_rect.color = Color.RED
		broadcast_state(false)
		

		
func broadcast_state(activate_doors: bool) -> void:
	if activate_doors or not lock:
		update_targets.emit(self, channel if activate_doors else 0, activate_doors)
		
	
		

	
