extends StaticBody2D

@onready var collision_shape:CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect = $ColorRect

func open_door() -> void:
	#Disables collision safely
	collision_shape.set_deferred("disabled", true)
	# Makes the door semi-transparent to show it is open
	color_rect.modulate.a = 0.25
	
func close_door() -> void:
	#Re-enables colision
	collision_shape.set_deferred("disabled", false)
	#Restore full visibility
	color_rect.modulate.a = 1.0	
	 
	
