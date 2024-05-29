extends CharacterBody2D

var openable = false
var closable = false
var opened = false
var lootable = false
var player_in_zone = false
var anim

func _ready():
	anim = $AnimatedSprite2D
	
func _process(_delta):
	play_anim()

func play_anim():
				
	if Input.is_action_just_pressed("ePressed") and player_in_zone == true:
		if lootable == true and openable == true:
			anim.play('Opening')
			closable = true
			openable = false
			Global.coins += randi_range(1, 15)
			print("Coins = ", Global.coins)
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
		if opened == false:
			openable = true
			lootable = true
		else:
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
	
