extends Node2D

@onready var label_score = %CanvasLayer/label_score
@onready var r_button = $CanvasLayer/resha_button

@export_category("game")
# game-points
@export var click_points : int = 0
@export var game_smothing : bool = true

# graphics
var r_button_scale_relaxed : Vector2
@export_category("rotation")
@export var r_button_rotation_relaxed : float = 0
@export var r_button_rotation_speed : float = 0.0
var r_button_rotation_point : float # point to rotate where

func _ready():
	label_score.text = str(click_points)
	r_button_scale_relaxed = r_button.scale


func _process(delta):
	r_button_rotation()


func _on_resha_button_button_down():
	click_points += 1
	label_score.text = str(click_points)
	r_button_rotation_point = 90.0


func _on_resha_button_button_up():
	r_button_rotation_point = 0.0


func _on_resha_button_pressed():
	# play animation - rotation
	pass

func _on_resha_button_mouse_entered():
	r_button.scale += Vector2(0.05, 0.05)
	r_button_rotation_point = 10.0


func _on_resha_button_mouse_exited():
	r_button.scale = r_button_scale_relaxed
	r_button_rotation_point = 0.0


func r_button_rotation():
	var _button_rotation : float
	var smoothing_distance : float
	
	if game_smothing:
		smoothing_distance = 0 # 0 - 25 # FIXME: add r_button_speed dependency
		if smoothing_distance < 0.0:
			smoothing_distance = 0.0
		elif smoothing_distance > 25.0:
			smoothing_distance = 25.0
		var weight : float = float(smoothing_distance + 0.1) / 100
		_button_rotation = lerp(r_button.rotation_degrees, r_button_rotation_point, weight)
	else:
		_button_rotation = r_button_rotation_point
	
	r_button.rotation_degrees = _button_rotation
