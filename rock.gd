extends Sprite2D

@export var circles: PackedVector2Array
@export var radii: PackedFloat32Array
@export var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material.set_shader_parameter("circleCoords", circles)
	material.set_shader_parameter("radii", radii)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera: Camera2D = player.get_node(player.get_meta("camera"))
	var rect = camera.get_viewport_rect()
	material.set_shader_parameter("offset", position + rect.size /2 - camera.position)
	
