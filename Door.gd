extends StaticBody2D
class_name Door

# Default to -1(All Channels). @export_flags gives checkboxes in the Inspector!
@export_flags("Channel 1", "Channel 2", "Channel 3", "Channel 4", "Channel 5") var channel : int = -1

@onready var collision_shape:CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect = $ColorRect

var is_active: bool = false

func _ready() -> void:
	# Add this door to the global "doors" group
	add_to_group("doors")
	deactivate() # Start in closed / solid state

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

	
