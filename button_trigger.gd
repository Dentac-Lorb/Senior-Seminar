extends Area2D
class_name ButtonTrigger

@export var door: StaticBody2D # Drag your Door node here in Inspector
@export var lock: bool = true   # When true, door stays open until pass-through!
@onready var color_rect: ColorRect = $ColorRect

var active_bodies: Array[Node2D] = []
var is_pressed: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if not active_bodies.has(body):
		active_bodies.append(body)
	
	is_pressed = true
	color_rect.color = Color.GREEN
	
	if door and door.has_method("open_door"):
		door.open_door()

func _on_body_exited(body: Node2D) -> void:
	active_bodies.erase(body)
	
	# If lock is ON, do not close when stepping off! Wait for pass-through.
	if lock:
		return
		
	# If lock is OFF (pressure plate mode), close when leaving
	if active_bodies.is_empty():
		is_pressed = false
		color_rect.color = Color.RED
		if door and door.has_method("close_door"):
			door.close_door()

func reset_button() -> void:
	active_bodies.clear()
	is_pressed = false
	color_rect.color = Color.RED
