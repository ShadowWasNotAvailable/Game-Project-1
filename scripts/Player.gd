extends CharacterBody2D

var enemy_attack_cooldown = true
var player_alive = true
var attacking = false
var PH_cooldown = false
var potion_CD = false
var current_dir = "none"

const speed = 100




func _ready():
	$AnimatedSprite2D.play("Front_idle")



func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	
	if Global.player_health <= 0:
		player_alive = false
		Global.player_health = 0
		print ("player has been killed")
		self.queue_free()
	if Global.player_health > 100:
		Global.player_health = 100
	if PH_cooldown == false:
		if Global.player_health < 100:
			PH_cooldown = true
			$passive_healing.start()
			Global.player_health += 5
			print("Healed 5 HP")
			print("Current HP = ", Global.player_health)



func player_movement(_delta):
	if Input.is_action_pressed("dPressed"):
		current_dir = "right"
		play_anim(1)
		if Input.is_action_pressed("sprint(shift)"):
			velocity.x = speed + 50
			velocity.y = 0
		else:
			velocity.x = speed
			velocity.y = 0
		
	elif Input.is_action_pressed("aPressed"):
		current_dir = "left"
		play_anim(1)
		if Input.is_action_pressed("sprint(shift)"):
			velocity.x = -speed - 50
			velocity.y = 0
		else:
			velocity.x = -speed
			velocity.y = 0
	elif Input.is_action_pressed("sPressed"):
		current_dir = "down"
		play_anim(1)
		if Input.is_action_pressed("sprint(shift)"):
			velocity.y = speed + 50
			velocity.x = 0
		else:
			velocity.y = speed
			velocity.x = 0
	elif Input.is_action_pressed("wPressed"):
		current_dir = "up"
		play_anim(1)
		if Input.is_action_pressed("sprint(shift)"):
			velocity.y = -speed - 50
			velocity.x = 0
		else:
			velocity.y = -speed
			velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	if potion_CD == false:
		if Input.is_action_pressed("hPressed"):
			if Global.h_potion > 0:
				if Global.player_health > 99:
					print("You arent injured!")
				else:
					print("You used a potion!")
					print("You healed 25 HP")
					Global.player_health += 25
					Global.h_potion -= 1
					print("You now have", Global.h_potion, " potions!")
					potion_CD = true
					$Potion_CD.start()
			elif Global.h_potion == 0:
				print("You dont have any potions to use!")
	move_and_slide()



func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("Side_walk")
		elif movement == 0:
			if attacking == false:
				anim.play("Side_idle")

	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("Side_walk")
		elif movement == 0:
			if attacking == false:
				anim.play("Side_idle")

	if dir == "down":
			anim.flip_h = true
			if movement == 1:
				anim.play("Front_walk")
			elif movement == 0:
				if attacking == false:
					anim.play("Front_idle")

	if dir == "up":
			anim.flip_h = true
			if movement == 1:
				anim.play("Back_walk")
			elif movement == 0:
				if attacking == false:
					anim.play("Back_idle")



func _on_player_hitbox_body_entered(body):
	if body.is_in_group("Slime"):
		Global.enemy_in_attack_range = true



func _on_player_hitbox_body_exited(body):
	if body.is_in_group("Slime"):
		Global.enemy_in_attack_range = false
		print("false")



func enemy_attack():
	if Global.enemy_in_attack_range and enemy_attack_cooldown == true:
			Global.player_health = Global.player_health - 5
			enemy_attack_cooldown = false
			$attack_cooldown.start()
			print(Global.player_health)



func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true



func attack():
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if Input.is_action_just_pressed("attack(space)"):
		Global.player_current_attack = true
		attacking = true
		if dir == "right":
			anim.flip_h = false
			anim.play("Side_attack")
			$deal_attack.start()
		if dir == "left":
			anim.flip_h = true
			anim.play("Side_attack")
			$deal_attack.start()
		if dir == "up":
			anim.flip_h = false
			anim.play("Back_attack")
			$deal_attack.start()
		if dir == "down":
			anim.flip_h = false
			anim.play("Front_attack")
			$deal_attack.start()



func _on_deal_attack_timeout():
	$deal_attack.stop()
	Global.player_current_attack = false
	attacking = false



func _on_passive_healing_timeout():
	PH_cooldown = false



func _on_potion_cd_timeout():
	potion_CD = false
	$Potion_CD.stop()
