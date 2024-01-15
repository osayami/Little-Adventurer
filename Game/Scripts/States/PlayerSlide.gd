extends StateBase

var slideSpeed : float = 650
var slideDuration : float = 0.3
var remainInSlideDuration : float
var facingDir : Vector3

func enter():
	super.enter()
	character.velocity.x = 0
	character.velocity.z = 0
	remainInSlideDuration = slideDuration
	
func state_update(_delta : float):
	remainInSlideDuration -= _delta
	facingDir = character.visual.transform.basis.z
	
	if remainInSlideDuration >0 :
		character.velocity.x = facingDir.x * slideSpeed * _delta
		character.velocity.z = facingDir.z * slideSpeed * _delta
	else:
		character.velocity.x = 0
		character.velocity.z = 0
		state_machine.switchTo("Idle")
	
