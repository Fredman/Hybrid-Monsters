extends CanvasLayer

var player_data
# Al HUD se le debe pasar el player completo
var player # No borrar

enum Mode {LOBBY, BATTLE}
var mode = Mode.LOBBY

func _ready():
	if DataManager.players.size() > 0:
		player_data = DataManager.players[Main.current_player].connect("dead", self, "_on_dead")
	
	$Debug/VarDificulty.text = str("var_dificulty: ", Main.var_dificulty)

	$Attributes.update()
	available_attributes()
	$Display.text = str("Level ", Main.current_level)

func _input(event):
	if event.is_action_pressed("inventory"):
		$Inventory/HUDInventory.pressed = not $Inventory/HUDInventory.pressed
		_on_HUDInventory_toggled($Inventory/HUDInventory.pressed)
		
		if $Inventory/HUDInventory.pressed:
			$Inventory.update_stats()
	elif event.is_action_pressed("attributes"):
		$HubOther.pressed = not $HubOther.pressed
		_on_HubOther_toggled($HubOther.pressed)
		$Inventory.update_stats()
	elif event.is_action_pressed("shop"):
		$ShopButton.pressed = not $ShopButton.pressed
		_on_ShopButton_toggled($ShopButton.pressed)
	elif event.is_action_pressed("ui_cancel"):
		$HUDMenuButton.pressed = not $HUDMenuButton.pressed
		_on_HUDMenuButton_toggled($HUDMenuButton.pressed)

func initial_config(mode = Mode.LOBBY):
	$Inventory.update_inv()
	
	if mode == Mode.LOBBY:
		$EnemiesAmount.hide()
		$EnemiesRequired.hide()
		$Status.hide()
	else:
		update_enemies_amount()
		update_enemies_required()
		connect_enemies()
		$Display/Anim.play("show")

func connect_enemies():
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.connect("dead", self, "_on_enemy_dead")

func update_enemies_amount():
	$EnemiesAmount.text = str(
		"Enemies: ", 
		Main.store_destroyed_enemies, 
		"/", 
		Main.total_enemies
	)

func update_enemies_required():
	$EnemiesRequired.text = str("Required: ", Main.enemies_required)

func available_attributes():
	if DataManager.stats[Main.current_player].get_points() > 0:
		$AvailableAttributes.play("idle")
	else:
		$AvailableAttributes.stop()
		$HubOther.self_modulate = Color("ffffff")

func tuiu_sound():
	SoundManager.play_sound(int(round(rand_range(SoundManager.Sound.TUIU_1, SoundManager.Sound.TUIU_2))))

func _on_HUDInventory_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	
	if button_pressed:
		$AnimInv.play("show")
	else:
		$AnimInv.play("hide")

func _on_Resume_pressed():
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	
	$HUDMenuButton.pressed = false
	$AnimMenu.play("hide")

func _on_Menu_pressed():
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	
	MusicManager.stop_music()
	get_tree().change_scene("res://scenes/Main.tscn")

func win():
	Main.result = Main.Result.WIN
	$WinLost.result()
	MusicManager.stop_anim()
	$AnimWinLost.play("show")
	
func _on_dead():
	Main.result = Main.Result.LOST
	$WinLost.result()
	MusicManager.stop_anim()
	$AnimWinLost.play("show")
	
func _on_enemy_dead():
	update_enemies_amount()
	
	if Main.enemies_required == Main.store_destroyed_enemies:
		$Display.text = str("Spawn Cave")
		$Display/Anim.play("show")
	elif Main.store_destroyed_enemies == Main.total_enemies:
		$Display.text = str("All Enemies Killed")
		$Display/Anim.play("show")
		Main.arrow_active = true

func _on_HubOther_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	
	if button_pressed:
		$AnimAttributes.play("show")
	else:
		$AnimAttributes.play("hide")

func _on_ShopButton_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	
	if button_pressed:
		$Shop.update_gold_amount()
		$Shop.update_weight()
		$Shop.update_inv_items()
		$AnimShop.play("show")
	else:
		$AnimShop.play("hide")

func _on_HUDMenuButton_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	
	if button_pressed:
		$AnimMenu.play("show")
	else:
		$AnimMenu.play("hide")

func _on_AnimWinLost_animation_finished(anim_name):
	if anim_name == "show":
		if Main.result == Main.Result.WIN:
			MusicManager.select_music(MusicManager.Music.DIGGING)
		else:
			MusicManager.select_music(MusicManager.Music.CRAZY)
		
		MusicManager.play_music()

func _on_Achievement_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	
	if button_pressed:
		$Achievements.update()
		$AnimAchievements.play("show")
	else:
		$AnimAchievements.play("hide")
