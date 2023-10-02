extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

const speed = 100
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("Front_idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		print ("player has been killed")
		self.queue_free()

func player_movement(delta):
	if Input.is_action_pressed("dPressed"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("aPressed"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("sPressed"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("wPressed"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("Side_walk")
		elif movement == 0:
			anim.play("Side_idle")

	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("Side_walk")
		elif movement == 0:
			anim.play("Side_idle")

	if dir == "down":
			anim.flip_h = true
			if movement == 1:
				anim.play("Front_walk")
			elif movement == 0:
				anim.play("Front_idle")

	if dir == "up":
			anim.flip_h = true
			if movement == 1:
				anim.play("Back_walk")
			elif movement == 0:
				anim.play("Back_idle")


func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("Slime"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("Slime"):
		enemy_inattack_range = false
		print("false")
		
func Slime():
	pass
		
func enemy_attack():
	if enemy_inattack_range:
		health = health - 0
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
		
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

#combat system 11:18

