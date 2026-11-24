extends Area2D

var collected: bool = false

func _on_body_entered(body: Node) -> void:
	if collected:
		return
	
	collected = true
	$CollisionShape2D.set_deferred("disabled", true)
	get_tree().call_group("hud", "add_score", 1)
	queue_free()
