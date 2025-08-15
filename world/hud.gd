extends CanvasLayer



func set_player_death():
	show()
	%SplashText.text = "YOU DIED."
	%MenuButton.show()
	%RespawnButton.show()


func set_level_win():
	show()
	%SplashText.text = "YOU WIN! CONGRATULATIONS!"
	%MenuButton.show()
	%RespawnButton.hide()


func clear():
	hide()
	%SplashText.text = ""
