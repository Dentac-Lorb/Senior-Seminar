extends Node
class_name LogicGate

@export var sources: Array[Node]
@export var targets: Array[Node]
@export_enum("AND", "OR", "NAND", "NOR", "XOR", "NOT") var gate: String
var source_inputs: Dictionary = {}

signal update_targets(node: Node, channel_mask: int, state: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for source in sources:
		if source.has_signal("update_targets"):
			source.connect("update_targets", update)
		source_inputs[source] = source.default_output() if source.has_method("default_output") else 0
			


func update(node: Node, channel_mask: int, state: bool):
	source_inputs[node] = channel_mask
	var state_out: int = -1 if state else 0
	#print(source_inputs.values())
	#print(source_inputs.values()[0] & source_inputs.values()[1])
	match(gate):
		"AND":
			state_out = source_inputs.values().reduce(func(a: int, b: int): return a & b, -1)
		"OR":
			state_out = source_inputs.values().reduce(func(a: int, b: int): return a | b, 0)
		"NAND":
			state_out = source_inputs.values().reduce(func(a: int, b: int): return ~(a & b), 0)
		"NOR":
			state_out = source_inputs.values().reduce(func(a: int, b: int): return ~(a | b), 0)
		"XOR":
			state_out = source_inputs.values().reduce(func(a: int, b: int): return a ^ b, 0)
		"NOT":
			state_out = ~channel_mask
	#print(state_out)
	update_targets.emit(self, state_out, state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
