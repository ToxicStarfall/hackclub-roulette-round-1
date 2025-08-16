extends Node2D


#var player_instance: Player
var main_level: Level
var current_level: Level
var last_level: Level
var sublevels = {}


func _ready() -> void:
	#await load_level("res://world/levels/testlevel.tscn", true)
	#main_level.enter()
	pass


func load_level(level_scene, first_level = false):
	var player
	if first_level:
		player = create_player()


	var level = load(level_scene).instantiate()
	main_level = level
	#current_level = level
	load_sublevels()
	add_child(level)

	level.level_entered.connect( _on_level_entered )
	level.level_exited.connect( _on_level_exited )
	level.level_changed.connect( _on_level_changed )
	level.level_won.connect( _on_level_won )
	level.enter()
	level.spawn_player(player)


func load_sublevels():
	for sublevel_key in main_level.sublevels:
		var sublevel = main_level.sublevels[sublevel_key].instantiate()
		sublevels.set(sublevel_key, sublevel)
		sublevel.level_entered.connect( _on_level_entered )
		sublevel.level_exited.connect( _on_level_exited )
		sublevel.level_changed.connect( _on_level_changed )
		sublevel.level_won.connect( _on_level_won )


func create_player():
	var player = preload("res://entities/player/player.tscn").instantiate()
	player.player_death.connect( _on_player_death )
	return player


func _on_level_changed(requester, linked_level_id):
	print("%s initiated level change to '%s'" % [requester, linked_level_id])
	if requester is Gate:
		last_level = current_level  # save the last level to return to
		var player = current_level.get_node("Player")
		current_level.remove_child(player)
		current_level.exit()
		self.remove_child(current_level)

		# Return to main level if unspecfied target
		if linked_level_id == "":
			#add_child(last_level)
			#last_level.enter()
			#last_level.spawn_player(player, requester)
			add_child(main_level)
			main_level.enter()
			main_level.spawn_player(player, requester)
		else:
			var new_level = sublevels.get(linked_level_id)
			add_child(new_level)
			new_level.enter()
			new_level.spawn_player(player, requester)
		pass


func _on_level_entered(level):
	#if level is !SubLevel:
		#main_level = s
	current_level = level
	# Notify level start
	pass


func _on_level_exited(_level):
	# Notify level success
	pass


func _on_level_won(_level):
	#if level is SubLevel
	print("Level Completed")
	%HUD.set_level_win()
	pass


func _on_player_death():
	%HUD.set_player_death()
	#%HUD.show()
	#%SplashText.text = "YOU DIED."


# Remove all saved values
func clear_world():
	self.remove_child(current_level)
	main_level = null
	current_level = null
	sublevels = {}


func clear_hud():
	%HUD.clear()
	#%HUD.hide()
	#%SplashText.text = ""


func _on_respawn_button_pressed() -> void:
	clear_hud()
	current_level.spawn_player( create_player() )
	#load_level("res://world/levels/testlevel.tscn", true)

func _on_menu_button_pressed() -> void:
	clear_world()
	clear_hud()
	get_parent().get_node("UserInterface").show()
	pass
