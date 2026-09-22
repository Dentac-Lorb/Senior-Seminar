extends Area2D

@export var target_door: StaticBody2D
@onready var color_rect: ColorRect = $ColorRect

var overlapping_objects: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node2D) -> void:
	overlapping_objects += 1
	if overlapping_objects == 1:
		color_rect.color = Color.GREEN
		if target_door and target_door.has_method("open_door"):
			target_door.open_door()
			
func _on_body_exited(body: Node2D) -> void:
	overlapping_objects -= 1
	if overlapping_objects <= 0:
		overlapping_objects = 0
		color_rect.color = Color.RED
		if target_door and target_door.has_method("close door"):
			target_door.close_door()				
	
	
	
