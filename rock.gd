extends Sprite2D

@export var circles: PackedVector2Array
@export var radii: PackedFloat32Array
@export var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material.set_shader_parameter("circleCoords", circles)
	material.set_shader_parameter("radii", radii)
	var colliders = get_parent().find_children("*", "CollisionShape2D")
	for i in range(min(colliders.size(), circles.size())):
		var collider: CollisionShape2D = colliders[i]
		collider.position = circles[i]
		var shape: CircleShape2D = collider.shape
		shape.radius = radii[i]
	
	var minx = 0
	var miny = 0
	var maxx = 0
	var maxy = 0
	for circle in circles:
		minx = min(minx, circle.x)
		miny = min(minx, circle.y)
		maxx = max(maxx, circle.x)
		maxy = max(maxy, circle.y)
	
	position.x = (minx + maxx)/2 
	position.y = (miny + maxy)/2
	#self.get_rect().size = Vector2(maxx-minx + 16, maxy-miny + 16)
	#self.apply_scale()
	#var texsize = self.texture.get_size() / self.scale
	self.apply_scale(Vector2(maxx-minx + 16, maxy-miny + 16) / self.get_rect().size)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera: Camera2D = player.get_node(player.get_meta("camera"))
	var rect = camera.get_viewport_rect()
	material.set_shader_parameter("offset", get_parent().position + rect.size /2 - camera.position)
	
