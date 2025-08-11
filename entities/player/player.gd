extends Entity
class_name Player


enum State {
	IDLE, RUNNING, JUMPING, FALLING,
}
enum Action {
	NONE,
	HIDING,
	STEALTH_ATTACK,
	JUMP_ATTACK,
}

const MOVEMENT_SPEED = 100.0
const JUMP_VELOCITY = 165.0
const GRAVITY = 400.0

var state := State.IDLE
var action := Action.NONE
var can_doublejump = true
var is_in_stealth = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	match state:
		State.IDLE: $Label.text = "idle"
		State.RUNNING: $Label.text = "running"
		State.FALLING: $Label.text = "falling"


func _physics_process(delta: float) -> void:
	#match state:
		#State.FALLING:
			#pass

	var move_dir =  Input.get_axis("move_left", "move_right")
	move_dir *= int(self.can_move)
	self.velocity.x = move_dir * MOVEMENT_SPEED

	if is_on_floor():
		if move_dir: state = State.RUNNING
		else: state = State.IDLE
		#can_doublejump = true  # reset doublejump
		#print(can_doublejump)
	#elif self.velocity.y > 0:
	else:
		state = State.FALLING
	#else:
		#state = State.JUMPING

	if Input.is_action_pressed("jump") and (state != State.FALLING): #or can_doublejump):
		velocity.y -= JUMP_VELOCITY
		velocity.y *= int(self.can_move)  # Ability checks
		#if state == State.FALLING: can_doublejump = false
		#print(can_doublejump)
	self.velocity.y += GRAVITY * delta
	move_and_slide()


func _input(event: InputEvent) -> void:
		pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	if action != Action.HIDING:
		#TODO Do a stealth attack range check

		if body is Enemy:
			body.kill()
			#body.queue_free()
