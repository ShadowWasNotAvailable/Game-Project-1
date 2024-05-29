extends CharacterBody2D

var openable = false
var closable = false
var opened = false
var lootable = true
var c_ammount = randi_range(1, 15)
var chance = randi_range(1,2)
var anim

func _ready():
	anim = $AnimatedSprite2D
	
func _process(_delta):
	play_anim()

func play_anim():
				
	if Input.is_action_just_pressed("ePressed") and player_in_zone == true:
		if lootable == true and openable == true:
			c_ammount = randi_range(1, 15)
			chance = randi_range(1, 2)
			anim.play('Opening')
			closable = true
			openable = false
			Global.coins += c_ammount
			print("You found ", c_ammount, " coins! ", "You now have ", Global.coins, " coins!")
			if chance == 1:
				if Global.h_potion > 2:
					print("You have to many potions! You could not pick up the potion you found...")
				else:
					Global.h_potion += 1
					print("You found a health potion! ", "You now have ", Global.h_potion, " potions!")
			
		elif openable:
			anim.play('Opening')
			closable = true
			openable = false
		elif closable:
			anim.play('Closing')
			opened = true
			openable = true
			lootable = false
			closable = false

func _on_hit_zone_body_entered(body):
	if body.is_in_group("player"):
			openable = true
		player_in_zone = true

func _on_hit_zone_body_exited(body):
	if body.is_in_group("player"):
		if closable:
			anim.play('Closing')
			opened = true
			openable = false
			lootable = false
			closable = false
		else:
			openable = false
		player_in_zone = false
	
