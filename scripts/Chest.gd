extends CharacterBody2D

var openable = false
var opened = false
var anim

func _ready():
	anim = $AnimatedSprite2D
	
func _process(_delta):
	play_anim()

func play_anim():
				
	if Input.is_action_just_pressed("ePressed"):
		if openable:
			anim.play('Opening')
			opened = true
			openable = false
		elif opened:
			anim.play('Closing')
			opened = false
			openable = true

func _on_hit_zone_body_entered(body):
	if body.is_in_group("player"):
		openable = true

func _on_hit_zone_body_exited(body):
	if body.is_in_group("player"):
		if opened:
			anim.play('Closing')
			openable = false
		else:
			openable = false
	
