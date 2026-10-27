extends Area2D
class_name Collectible

@export var value: int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	# Checks if the colliding body is the fish
	if body.name.to_lower().contains("fish") or body is CharacterBody2D:
		# Notify any nodes in the "hud" group safely
		get_tree().call_group("hud", "add score", value)
		print("Collected! +", value)
		queue_free() # Despawn the collectible
