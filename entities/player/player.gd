extends Entity
class_name Player


enum State {
	IDLE, RUNNING, JUMPING, FALLING,
}
enum Action {
	NONE,
	STEALTH,
	JUMP_ATTACK,
}

const MOVEMENT_SPEED = 100.0
const JUMP_VELOCITY = 150.0
const GRAVITY = 400.0

#var health = 3
var state := State.IDLE
var is_in_stealth = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	match state:
		State.IDLE: $Label.text = "idle"
		State.RUNNING: $Label.text = "running"
		State.FALLING: $Label.text = "falling"


func _physics_process(delta: float) -> void:
	match state:
		State.FALLING:
			pass

	var move_dir =  Input.get_axis("move_left", "move_right")
	move_dir *= int(self.can_move)
	self.velocity.x = move_dir * MOVEMENT_SPEED

	if is_on_floor():
		if move_dir: state = State.RUNNING
		else: state = State.IDLE
	#elif self.velocity.y > 0:
	else:
		state = State.FALLING
	#else:
		#state = State.JUMPING


	if Input.is_action_pressed("jump") and state != State.FALLING:
		velocity.y -= JUMP_VELOCITY
	self.velocity.y += GRAVITY * delta
	move_and_slide()


func _input(event: InputEvent) -> void:
		pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.queue_free()
