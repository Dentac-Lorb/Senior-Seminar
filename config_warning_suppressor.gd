extends CollisionShape2D

class_name ConfigWarningSuppressor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
