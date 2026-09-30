extends CharacterBody2D
@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer2D = $jump


const SPEED = 500.0
const JUMP_VELOCITY = -1400.0


func _physics_process(delta: float) -> void:
	# add animation
	if velocity.x > 1 or velocity.x < -1:
		animate.animation = "walk"
	else:
		animate.animation = "idle"
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animate.animation = "idle" 

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == 1.0:
		animate.flip_h = false
	elif direction == -1.0:
		animate.flip_h = true
