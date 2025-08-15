class_name Enemy
extends Entity

enum State {
	IDLE, MOVING, JUMPING, FALLING,
}
enum Action {
	NONE,
	WANDERING, LOOKING, SEARCHING, CHASING,
	ATTACKING,
}

const MOVEMENT_SPEED = 40.0
const WANDER_DIST = 100.0

#@export var wandering = true
var state := State.IDLE
@export var action := Action.NONE
@export var action_list: Array[Action] = []

@export var dir = 1  # Start looking right
var action_duration = 0.0

@onready var wander_timer = get_tree().create_timer(10)


func _ready() -> void:
	if has_node("SightRange"):
		$SightRange.body_entered.connect( _on_sight_range_body_entered )
		$SightRange.body_exited.connect( _on_sight_range_body_exited )
	#if has_node("AttackRange"):
		#$AttackRange.body_entered.connect()
		#$AttackRange.body_exited.connect()
	wander()


func _process(delta: float) -> void:
	if has_node("SightRange"):
		if velocity.x < 0: $SightRange.scale.x = -1
		elif velocity.x > 0: $SightRange.scale.x = 1
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false


func _physics_process(delta: float) -> void:
	self.velocity.y += Game.GRAVITY * delta

	action_duration += delta
	match action:
		Action.CHASING:
			pass
		Action.NONE: # equivalent to idle
			if action_duration >= 4:
				wander()
			$AnimatedSprite2D.play("idle")
		Action.WANDERING:
			if action_duration >= 4:
				idle()
			$AnimatedSprite2D.play("moving")
	move_and_slide()


func _on_sight_range_body_entered(body):
	#if body is Player:
		#chase()
	pass

func _on_sight_range_body_exited(body):
	#if body is Player:
		#idle()
	pass


func action_changed():
	action_duration = 0.0

func idle(time=null):
	action_duration = 0.0
	action = Action.NONE
	self.velocity.x = 0
	#await get_tree().create_timer(time).timeout
	#wander()

func wander():
	action_duration = 0.0
	action = Action.WANDERING
	dir *= -1
	self.velocity.x = MOVEMENT_SPEED * dir
	#await get_tree().create_timer(4).timeout
	#idle(4)

func chase(target=null):
	var dir = get_tree().get_first_node_in_group("player").position.x - self.position.x
	velocity.x = min(dir,1) * MOVEMENT_SPEED
	print(velocity.x)


class Actions:
	func idle():
		self.velocity.x = 0

	func wander():
		self.dir *= -1
		self.velocity.x = MOVEMENT_SPEED * self.dir

	#func attack(target):
		#get_tree().get_first_node_in_group("player")
