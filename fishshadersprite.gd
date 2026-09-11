extends Node2D

@export var camera: Camera2D
@export var head: CharacterBody2D
@export var middle: RigidBody2D
@export var tail: RigidBody2D
@export var tail2: RigidBody2D

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
	var tail2pos = tail2.position + rect.size /2 
	position = head.position
	var positions = [headpos, (headpos + middlepos) / 2, middlepos, (middlepos + tailpos) / 2, tailpos, (tailpos + tail2pos) / 2, tail2pos]
	var radii = [15, 20, 12, 10, 8, 5, 5]
	var bounds = [INF,-INF,INF,-INF]
	
	for i in range(len(positions)):
		if positions[i].x - radii[i] - 10 < bounds[0]:
			bounds[0] = positions[i].x - radii[i] - 10
		if positions[i].x + radii[i] + 10 > bounds[1]:
			bounds[1] = positions[i].x + radii[i] + 10
		if positions[i].y - radii[i] - 10 < bounds[2]:
			bounds[2] = positions[i].y - radii[i] - 10
		if positions[i].y + radii[i] + 10 > bounds[3]:
			bounds[3] = positions[i].y + radii[i] + 10
	
	
	#material.set_shader_parameter("pos1", headpos)
	#material.set_shader_parameter("pos2", middlepos)
	#material.set_shader_parameter("pos3", tailpos)
	material.set_shader_parameter("positions", positions)
	material.set_shader_parameter("radii", radii)
	material.set_shader_parameter("bounds", bounds)
