extends CharacterBody2D

var openable = false
var opened = true


func play_anim(movement):
	var anim = $AnimatedSprite2D

	if openable:
		if Input.is_action_pressed("ui_up"):
				anim.play('Opening')
				anim.queue('Open')
				opened = true
				
		if Input.is_action_pressed("ui_down"):
			if opened:
				anim.play('Closing')
				anim.queue('Closed')
				opened = false

func _on_hit_zone_body_entered(body):
	openable = true


func _on_hit_zone_body_exited(body):
	openable = false
