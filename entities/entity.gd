class_name Entity
extends CharacterBody2D

@export_category("Attributes")
@export var max_health = 1
@export var body_damage = 1
@export var movement_speed = 100.0

@export_category("Configuration")
@export var Hitbox: Area2D

var health = max_health

var can_move = true


func heal(amount: int):
	health = min(health + amount, max_health)


func damage(amount: int):
	health = max(health - amount, 0)
	if health == 0:
		kill()


func kill():
	print("%s died." % [self])


func set_state():
	pass
