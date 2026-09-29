extends Area2D
class_name ButtonTrigger

# Default to -1(All Channels). @export_flags gives checkboxes in the Inspector!
@export_flags("Channel 1", "Channel 2", "Channel 3", "Channel 4", "Channel 5") var channel : int = -1

@onready var color_rect: ColorRect = $ColorRect

var overlapping_objects: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	overlapping_objects += 1
	if overlapping_objects == 1:
		color_rect.color = Color.GREEN
		broadcast_state(true)
		
func _on_body_exited(body: Node2D) -> void:
	overlapping_objects -= 1
	if overlapping_objects <= 0:
		overlapping_objects = 0
		color_rect.color = Color.RED
		broadcast_state(false)
		
func broadcast_state(activate_doors: bool) -> void:
	# Find all doors in the scene and send the bitwise signal
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		if door.has_method("matches_channel") and door.matches_channel(channel):
			if activate_doors:
				door.activate()
			else:
				door.deactivate()
	
		

	
