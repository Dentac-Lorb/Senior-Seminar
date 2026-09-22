extends Area2D

@export_file("*.tscn") var next_level: String
var changing_level := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "head" and not changing_level:
		changing_level = true
		get_tree().change_scene_to_file(next_level)
