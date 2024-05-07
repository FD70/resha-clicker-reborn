extends Node2D

@onready var label_score = %CanvasLayer/label_score
@onready var r_button = $CanvasLayer/resha_button

var click_points : int = 0
var r_button_scale_relaxed : Vector2

func _ready():
	label_score.text = str(click_points)
	r_button_scale_relaxed = r_button.scale
	

func _process(delta):
	pass


func _on_resha_button_button_down():
	print("b_down")
		
	click_points += 1
	label_score.text = str(click_points)
	r_button.rotation_degrees = 90


func _on_resha_button_button_up():
	print("b_up")
	r_button.rotation_degrees = 0


func _on_resha_button_pressed():
	# play animation - rotation
	pass

func _on_resha_button_mouse_entered():
	print("entered")
	r_button.scale += Vector2(0.05, 0.05)


func _on_resha_button_mouse_exited():
	print("exited")
	
	r_button.scale = r_button_scale_relaxed
	r_button.rotation_degrees = 0

