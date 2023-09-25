extends CharacterBody2D

const speed = 100
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("Front_idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
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





func _on_player_hitbox_body_entered(body):
	pass # Replace with function body.


func _on_player_hitbox_body_exited(body):
	pass # Replace with function body.