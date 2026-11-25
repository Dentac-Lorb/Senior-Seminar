extends Door
class_name ShaderDoor


@export var thickness: int = 15
@export var open_speed: float = 1.0
@export var player: Node2D

var openness: float = 0.0

var fulcrum_1
var fulcrum_2

func _init() -> void:
	if not has_node("ColorRect"):
		var color_rect = ColorRect.new()
		add_child(color_rect)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if not player:
		player = get_node("Player")
		
	
	var rect = collision_shape.shape.get_rect()
	color_rect.size = Vector2(rect.size.y, rect.size.y + 20)
	var fulcrum_distance = rect.size.y / 2 - 5
	
	fulcrum_1 = Vector2.RIGHT.rotated(rotation - PI/2) * fulcrum_distance
	fulcrum_2 = Vector2.RIGHT.rotated(rotation + PI/2) * fulcrum_distance
	
	var shade_mat = ShaderMaterial.new()
	shade_mat.shader = load("res://door.gdshader")
	color_rect.set_position(-color_rect.size/2)
	
	color_rect.material = shade_mat
	
	var theta = global_rotation - PI
	
	color_rect.material.set_shader_parameter("door_size", rect.size.y / 2)
	color_rect.material.set_shader_parameter("angle", rotation)
	color_rect.material.set_shader_parameter("rotation", Transform2D(theta, Vector2.ZERO))
	color_rect.material.set_shader_parameter("fulcrum1", fulcrum_1)
	color_rect.material.set_shader_parameter("fulcrum2", fulcrum_2)
	color_rect.material.set_shader_parameter("openness", 0)
	
	
	
	

func set_openness():
	var top_theta = (-PI/2) * openness
	var bottom_theta = (PI/2) * openness
	color_rect.material.set_shader_parameter("open_top", Transform2D(top_theta, Vector2.ZERO))
	color_rect.material.set_shader_parameter("open_bottom", Transform2D(bottom_theta, Vector2.ZERO))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_active and openness < 1.0:
		openness = min(openness + delta * open_speed, 1)
		#color_rect.material.set_shader_parameter("openness", openness)
		set_openness()
	if not is_active and openness > 0.0:
		openness = max(openness - delta * open_speed, 0)
		#color_rect.material.set_shader_parameter("openness", openness)
		set_openness()
	
	var camera: Camera2D = player.get_node(player.get_meta("camera"))
	var rect = camera.get_viewport_rect()
	color_rect.material.set_shader_parameter("offset", position + rect.size /2 - camera.position)
	
