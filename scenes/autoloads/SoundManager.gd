extends Node

enum Sound {
	HIT_1,
	HIT_2,
	HIT_3,
	HIT_4,
	LEVEL_UP,
	SWORD_1,
	SWORD_2,
	SWORD_3,
	NOPE,
	TAKE_ITEM,
	DROP,
	BUBBLE,
	MINE,
	SPELL,
	NOTIFICATION,
	COIN_1,
	COIN_2,
	COIN_3,
	BUTTON_PRESSED
}

func play_sound(sound):
	if not Main.sound_enable:
		return

	match sound:
		Sound.HIT_1:
			$Hit1.play()
		Sound.HIT_2:
			$Hit2.play()
		Sound.HIT_3:
			$Hit3.play()
		Sound.HIT_4:
			$Hit4.play()
		Sound.LEVEL_UP:
			$LevelUp.play()
		Sound.SWORD_1:
			$Sword1.play()
		Sound.SWORD_2:
			$Sword2.play()
		Sound.SWORD_3:
			$Sword3.play()
		Sound.NOPE:
			$Nope.play()
		Sound.TAKE_ITEM:
			$TakeItem.play()
		Sound.DROP:
			$Drop.play()
		Sound.BUBBLE:
			$Bubble.play()
		Sound.MINE:
			$Mine.play()
		Sound.SPELL:
			$Spell.play()
		Sound.NOTIFICATION:
			$Notification.play()
		Sound.COIN_1:
			$Coin1.play()
		Sound.COIN_2:
			$Coin2.play()
		Sound.COIN_3:
			$Coin3.play()
		Sound.BUTTON_PRESSED:
			$ButtonPressed.play()
	