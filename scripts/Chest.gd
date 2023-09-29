extends CharacterBody2D

var openable = false
var opened = false
var anim

func _ready():
	anim = $AnimatedSprite2D
	
func _process(_delta):
	play_anim()

func play_anim():

	if openable:
		if Input.is_action_pressed("ui_page_up"):
				anim.play('Opening')
				opened = true
				
		if Input.is_action_pressed("ui_page_down"):
			if opened:
				anim.play('Closing')
				opened = false

func _on_hit_zone_body_entered(body):
	if body.is_in_group("player"):
		openable = true
		print(openable)
	

func _on_hit_zone_body_exited(body):
	if body.is_in_group("player"):
		if opened:
			anim.play('Closing')
			openable = false
		else:
			openable = false
	
