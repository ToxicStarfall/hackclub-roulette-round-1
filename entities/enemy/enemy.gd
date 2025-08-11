class_name Enemy
extends Entity

enum State {
	IDLE, MOVING, JUMPING, FALLING,
}
enum Action {
	NONE,
	WANDERING, SEARCHING, CHASING,
	ATTACKING,
}

const MOVEMENT_SPEED = 40.0
const WANDER_DIST = 100.0

@onready var wander_timer = get_tree().create_timer(10)

var state := State.IDLE
var action := Action.NONE


func _ready() -> void:
	#if has_node("SightRange"): $SightRange.body_entered.connect()
	#if has_node("AttackRange"): $AttackRange.body_entered.connect()
	wander()
	pass


func _process(delta: float) -> void:
	#if self.has_node("Sprite2D"):
	if has_node("SightRange"):
		if velocity.x < 0: $SightRange.scale.x = -1
		elif velocity.x > 0: $SightRange.scale.x = 1
	#if has_node("SightRange"): $SightRange.position.x = position.x * float(bool(velocity.x))


func _physics_process(delta: float) -> void:
	#self.velocity.x = -MOVEMENT_SPEED
	self.velocity.y += Game.GRAVITY * delta
	move_and_slide()


func idle(time):
	self.velocity.x = 0
	await get_tree().create_timer(time).timeout
	wander()


func wander():
	self.velocity.x = -MOVEMENT_SPEED
	await get_tree().create_timer(4).timeout
	idle(4)


func wander_random():
	pass
