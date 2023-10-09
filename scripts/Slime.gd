extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

var health = 50
var player_inattack_zone = false
var Can_take_dmg = true

func _physics_process(delta):
	deal_with_damage()
	
	
	if player_chase and player:
		position += (player.position - position)/speed

		$AnimatedSprite2D.play("Walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("Idle")


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_chase = true


func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_chase = false
	

	

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
			Can_take_dmg = false
			health = health - 10
			print("slime health =", health)
			if health <= 0:
				if Global.player_health < 100:
					Global.player_health += 25
					print("Healed 25 HP")
				health = 0
				player_inattack_zone = false
				$AnimatedSprite2D.play("Death")
				$dying.start()



func _on_dying_timeout():
	$dying.stop()
	self.queue_free()
	



func _on_take_damage_timeout():
	Can_take_dmg = true
