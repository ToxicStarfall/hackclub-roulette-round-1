class_name Enemy
extends Entity


const MOVEMENT_SPEED = 40.0
const WANDER_DIST = 100.0

#@onready var timer = get_tree().create_timer(10)

func _physics_process(delta: float) -> void:
	self.velocity.x = -MOVEMENT_SPEED
	self.velocity.y += Game.GRAVITY * delta
	move_and_slide()
	pass
