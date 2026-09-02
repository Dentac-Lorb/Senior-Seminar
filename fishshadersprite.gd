extends Node2D

@export var camera: Camera2D
@export var head: CharacterBody2D
@export var middle: RigidBody2D
@export var tail: RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#scale = camera.get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rect = camera.get_viewport_rect()
	var headpos = head.position + rect.size /2 
	var middlepos = middle.position + rect.size /2 
	var tailpos = tail.position + rect.size /2 
	position = head.position
	var positions = [headpos, (headpos + middlepos) / 2, middlepos, (middlepos + tailpos) / 2, tailpos]
	var radii = [15, 20, 12, 10, 8]
	#material.set_shader_parameter("pos1", headpos)
	#material.set_shader_parameter("pos2", middlepos)
	#material.set_shader_parameter("pos3", tailpos)
	material.set_shader_parameter("positions", positions)
	material.set_shader_parameter("radii", radii)
