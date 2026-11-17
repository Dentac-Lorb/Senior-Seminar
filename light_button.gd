extends ColorRect
class_name IndicatorLight

@export var player: Node2D
@export var off_color: Color = Color.RED
@export var on_color: Color = Color.GREEN
@export var sources: Array[Node]
@export_flags("Channel 1", "Channel 2", "Channel 3", "Channel 4", "Channel 5") var channel : int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not player:
		var parent = self
		while parent.get_parent() != null:
			parent = parent.get_parent()
		player = parent.find_child("Player")
	if get_parent() is ButtonTrigger:
		var bt = get_parent() as ButtonTrigger
		var cr: ColorRect = bt.find_child("ColorRect")
		if cr: cr.visible = false
		if bt not in sources:
			sources.append(bt)
	for source in sources:
		if source.has_signal("update_targets"):
			source.connect("update_targets", update)
	self.material = ShaderMaterial.new()
	self.material.shader = load("res://light_button.gdshader")
	self.position = Vector2(-20, -20)
	material.set_shader_parameter("color", off_color)
	
		
func update(node: Node, channel_mask: int, state: bool):
	if channel_mask & channel != 0:
		material.set_shader_parameter("color", on_color)
	else:
		material.set_shader_parameter("color", off_color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera: Camera2D = player.get_node(player.get_meta("camera"))
	var rect = camera.get_viewport_rect()
	material.set_shader_parameter("center", get_parent().position + rect.size /2 - camera.position)
