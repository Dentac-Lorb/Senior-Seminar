extends StaticBody2D


@export var num_colliders: int = 5

@export var circles: PackedVector2Array
@export var radii: PackedFloat32Array
@export var player: Node2D

var sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var colliders: Array[CollisionShape2D] = []
	for i in range(num_colliders):
		var collider = CollisionShape2D.new()
		var shape = CircleShape2D.new()
		collider.shape = shape
		colliders.append(collider)
		add_child(collider)
	
	if not player:
		var parent = self
		while parent.get_parent() != null:
			parent = parent.get_parent()
		player = parent.find_child("Player")
		
	sprite = RockSprite.new()
	sprite.external_colliders = colliders
	sprite.circles = circles
	sprite.radii = radii
	sprite.player = player
	sprite.texture = PlaceholderTexture2D.new()
	var shader = ShaderMaterial.new()
	shader.shader = load("res://rock.gdshader")
	var tex = CompressedTexture2D.new()
	tex.copy_from_resource(load("res://cc0/dirt2.png"))
	shader.set_shader_parameter("sandTexture", tex)
	sprite.material = shader
	
	self.add_child(sprite)
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
