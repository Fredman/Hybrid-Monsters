# HMItem.gd
#

extends "res://addons/rpg_elements/nodes/RPGItem.gd"

enum Materials {
	WOOD,
	IRON,
	DIAMOND,
	RUBY
}

enum ItemType {
	GLOVES,
	SWORD,
	POTION,
	BOOK
}

func get_item_type_name():
	match self.item_type:
		ItemType.GLOVES:
			return "Gloves"
		ItemType.SWORD:
			return "Sword"
		ItemType.POTION:
			return "Potion"
		ItemType.BOOK:
			return "Book"