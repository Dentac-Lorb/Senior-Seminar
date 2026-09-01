extends CharacterBody2D

@export var speed = 400
@export var constraint_magnitude = 100
@export var middle: RigidBody2D
@export var tail: RigidBody2D
var wave_timer = 0.0
var go_to_pos: Vector2 = Vector2.ZERO
var look: float = 0.0
var mouse_down: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#material.set_shader_parameter("pos1", position)
	#material.set_shader_parameter("pos2", get_parent().get_child(1).position)
	#material.set_shader_parameter("pos2", get_parent().get_child(2).position)
	
	pass
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"click"):
		mouse_down = true
	if event.is_action_released(&"click"):
		mouse_down = false
		
		

	
func get_input(delta):
	if mouse_down:
		go_to_pos = get_global_mouse_position()
	var squared_dist = position.distance_squared_to(go_to_pos)
	var moving = squared_dist > 50
	
	#MOUSE_BUTTON_LEFT
	#look_at(go_to_pos)
	var diff = 0
	var bend = 0
	if moving:
		diff = angle_difference(position.angle_to_point(go_to_pos), look)
		bend = diff * 10 * delta
		look -= bend
	rotation = look
	
	#var bend = angle_difference(position.angle_to_point(middle.position), rotation - PI)
	#if bend > PI/3:
	#	rotation = 
		
	
	#get_child(0).look_at(get_global_mouse_position())
	#var input_direction = Input.get_vector("left", "right", "up", "down")
	#velocity = input_direction * speed
	if wave_timer > 100:
		wave_timer -= 100
	rotation += (0.05 + (0.15 if moving and squared_dist > 100 else 0.0)) * sin(wave_timer * 5)
	if moving:
		velocity = transform.x * speed * max(1-(diff**2), 0.1)
	else: 
		velocity = Vector2.ZERO
	
	
func _physics_process(delta):
	wave_timer += delta
	get_input(delta)
	
	move_and_slide()
	
	var scaled_mag = 100 + constraint_magnitude * (abs(angle_difference(rotation - PI, position.angle_to_point(middle.position))) ** 8)
	middle.apply_force(Vector2.from_angle(rotation - PI) * scaled_mag)
	
	#var scaled_mag_2 = constraint_magnitude * (abs(angle_difference(position.angle_to_point(middle.position), middle.position.angle_to_point(tail.position))) ** 2)
	var scaled_mag_2 = 100 + constraint_magnitude * (abs(angle_difference(rotation - PI, position.angle_to_point(tail.position))) ** 8)
	tail.apply_force(Vector2.from_angle(position.angle_to_point(tail.position)) * scaled_mag_2)
	
	
