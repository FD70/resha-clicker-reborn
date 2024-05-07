extends Node2D

@onready var label_score = %CanvasLayer/label_score
@onready var resha_button = $CanvasLayer/resha_button

var click_points : int = 0

func _ready():
	label_score.text = str(click_points)
	

func _process(delta):
	pass


func _on_resha_button_button_down():
	click_points += 1
	label_score.text = str(click_points)
	print("pressed")


func _on_resha_button_mouse_entered():
	print("entered")


func _on_resha_button_mouse_exited():
	print("exited")
