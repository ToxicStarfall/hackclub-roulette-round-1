class_name StaticEntity
#extends PhysicsBody2D
extends StaticBody2D


@export_category("Attributes")
@export var max_health = 1
@export var attack_damage = 0
#@export var movement_speed = 100.0

@export_category("Configuration")
@export var Hitbox: Area2D

@export_group("Attribute Flags")
#@export var can_heal = true
#@export var can_move = true
@export var dammageable = true
@export var destroyable = true

var health = max_health


#func heal(amount: int):
	#if can_heal:
		#health = min(health + amount, max_health)
	#else: print("%s is unable to heal." % [self])


func damage(amount: int):
	if dammageable:
		health = max(health - amount, 0)
		if health == 0:
			destroy()
	else: print("%s is immune to damage." % [self])


func destroy():
	if destroyable:
		print("%s was destroyed." % [self])
		#TODO Death sprites
		#TODO Corpse decay timer
		self.queue_free()
	else:  print("%s is indestructable." % [self])


#func set_state():
	#pass
