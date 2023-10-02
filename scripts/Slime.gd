extends CharacterBody2D

var speed = 80
var player_chase = false
var player = null

func _physics_process(delta):
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
	

func _on_enemy_hitbox_body_exited(body):
	if body.is_in_group("player"):
		player_chase = true
