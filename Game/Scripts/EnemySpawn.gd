extends StateBase

@export var materialEffectAnimationPlayer : AnimationPlayer
var spawnDuration : float = 1.5


func state_update(_delta : float):
	spawnDuration -= _delta
	if spawnDuration <=0 :
		state_machine.switchTo("ChasePlayer")

func enter():
	super.enter()
	materialEffectAnimationPlayer.play("Spawn")
