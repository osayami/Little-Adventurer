extends StateBase

var stopDistance : float = 2.2


func state_update(_delta : float):
	character.navAgent.target_position = character.player.global_position
	
	character.direction = character.navAgent.get_next_path_position() - character.global_position
	character.direction.normalized()
	
	
		
	character.velocity = character.velocity.lerp(character.direction * character.SPEED , _delta)
	character.animation_player.play("NPC_01_WALK")
	
	if character.velocity.length() > 0.2 :
		var lookDir = Vector2(character.velocity.z , character.velocity.x)
		character.visualNode.rotation.y = lookDir.angle()
		
	if character.navAgent.distance_to_target() < stopDistance:
		state_machine.switchTo("Attack")
		
	if character.currentHealth == 0:
		state_machine.switchTo("Dead")
