extends CanvasLayer
class_name HUD

@onready var score_label: Label = $ScoreLabel

var current_score: int = 0

func _ready() -> void:
	update_ui()
	
func add_score(amount: int) -> void:
	current_score += amount
	print(">>> add_score CALLED! New score: ", current_score)
	update_ui()
	
func update_ui() -> void:
	if score_label:
		score_label.text = "Score: %d" % current_score
