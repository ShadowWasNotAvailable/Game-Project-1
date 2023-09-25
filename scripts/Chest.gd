extends CharacterBody2D

var openable = false
var opened = true


func play_anim(_movement):
	var anim = $AnimatedSprite2D
	
	if opened:
		anim.play("Open")
	else:
		anim.play("Closed")
	
	
	if openable:
		if Input.is_action_pressed("ui_up"):
			anim.play("Opening")
			opened = true

func _on_hit_zone_body_entered(_body):
	openable = true
		


func _on_hit_zone_body_exited(_body):
	openable = false