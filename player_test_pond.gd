extends Node2D


#@export var player_prototype: PackedScene
@export var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player = player_prototype.instantiate()
	#add_child(player)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
