extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null
var dying = false
var speed_up
var SU_CD = false
var damaged = false
var chance = randi_range(1,2)
var health = randi_range(20, 50)
var health_max = health
var c_ammount = randi_range(1, 5)
var player_inattack_zone = false
var Can_take_dmg = true



func _physics_process(_delta):
	deal_with_damage()
	
	
	if player_chase and player:
		position += (player.position - position)/speed

		$AnimatedSprite2D.play("Walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	elif dying:
		$AnimatedSprite2D.play("Death")
	elif damaged:
		$AnimatedSprite2D.play("Damaged")
	else:
		$AnimatedSprite2D.play("Idle")
	if SU_CD == false:
		if speed_up:
			speed -= 1
			SU_CD = true
			$speed_up.start()
		else:
			speed = 50
	if speed < 25:
		speed = 25



func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_chase = true
		speed_up = true



func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_chase = false
		speed_up = false
	



func _on_enemy_hitbox_body_entered(body):
	if body.is_in_group("player"):
		player_chase = false
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
	if body.is_in_group("player"):
		player_inattack_zone = true



func _on_enemy_hitbox_body_exited(body):
	if body.is_in_group("player"):
		player_chase = true
	if body.is_in_group("player"):
		player_inattack_zone = false
		
func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		if Can_take_dmg:
			$take_damage.start()
			damaged = true
			Can_take_dmg = false
			health = health - 10
			print("slime health =", health)
			if health <= 0:
				c_ammount = randi_range(1, 5)
				Global.coins += c_ammount
				Global.XP += health_max * 2
				print("You gained", health_max * 2, "XP")
				print("You found ", c_ammount, " coins in the slime's corpse! ", "You now have ", Global.coins, " coins!")
				dying = true
				player_inattack_zone = false
				Global.enemy_in_attack_range = false
				if Global.player_health < 100:
					Global.player_health += 25
					print("Healed 25 HP")
				health = 0
				$AnimatedSprite2D.play("Death")
				$dying.start()



func _on_dying_timeout():
	$dying.stop()
	self.queue_free()
	



func _on_take_damage_timeout():
	Can_take_dmg = true
	damaged = false



func _on_speed_up_timeout():
	SU_CD = false
