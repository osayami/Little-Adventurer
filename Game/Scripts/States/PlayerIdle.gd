extends StateBase


func state_update(_delta : float):
	if character.attackKey_pressed:
		state_machine.switchTo("Attack")
	if character.slideKey_pressed:
		state_machine.switchTo("Slide")
	if character.direction:
		state_machine.switchTo("Run")
