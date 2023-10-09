extends CharacterBody2D

var openable = false
var closable = false
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
			closable = true
			openable = false
		elif closable:
			anim.play('Closing')
			opened = true
			closable = false

func _on_hit_zone_body_entered(body):
	if body.is_in_group("player"):
		if opened == false:
			openable = true

func _on_hit_zone_body_exited(body):
	if body.is_in_group("player"):
		if closable:
			anim.play('Closing')
			openable = false
			closable = false
			opened = true
		else:
			openable = false
	
