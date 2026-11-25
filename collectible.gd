extends Area2D
class_name Collectible

@export var value: int = 1
var collected: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	collected = true
	$CollisionShape2D.set_deferred("disabled", true)
	get_tree().call_group("hud", "add_score", 1)
	queue_free()
	
