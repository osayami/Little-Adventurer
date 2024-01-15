extends StateBase

func enter():
	super.enter()
	state_machine.get_parent().remove_from_group("Player")
	await get_tree().create_timer(2).timeout
	character.isDead = true
