extends Node2D

@onready var label_score = %CanvasLayer/UI/label_score
@onready var label_speed = $CanvasLayer/UI/text_speed_value
@onready var r_button = $CanvasLayer/resha_button

@export_category("game")
# game-points
@export var click_points : int = 0
@export var game_smoothing : bool = true

# graphics
var r_button_scale_relaxed : Vector2
var r_button_scale_point : Vector2 # point to scale where
@export_category("rotation")
@export var r_button_rotation_relaxed : float = 0.0
@export var r_button_rotation_speed : float = 0.0 # 0 - 1.0
var r_button_rotation_point : float # point to rotate where

# s_ (sound)
@onready var s_hover = $SFX/r_hover
@onready var s_keys = [
	$SFX/key00,
	$SFX/key01,
]

func _ready():
	label_score.text = str(click_points)
	label_speed.text = str(r_button_rotation_speed)
	r_button_scale_relaxed = r_button.scale
	r_button_scale_point = r_button_scale_relaxed


func _process(delta):
	r_button_rotation()
	r_button_scale()
	

func game_click():
	click_points += 1
	r_button_rotation_speed_changer()


func _on_resha_button_button_down():
	game_click()
	
	s_keys.pick_random().play()
	
	label_score.text = str(click_points)
	r_button_rotation_point = 90.0
	r_button_scale_point = r_button_scale_relaxed - Vector2(0.05, 0.05)


func _on_resha_button_button_up():
	r_button_rotation_point = 0.0
	r_button_scale_point = r_button_scale_relaxed


func _on_resha_button_pressed():
	# play animation - rotation
	pass

func _on_resha_button_mouse_entered():
	s_hover.play()
	
	r_button_scale_point = r_button_scale_relaxed + Vector2(0.05, 0.05)
	r_button_rotation_point = 10.0


func _on_resha_button_mouse_exited():
	r_button_scale_point = r_button_scale_relaxed
	r_button_rotation_point = 0.0


func r_button_rotation():
	var _button_rotation : float
	var smoothing_distance : float
	
	if game_smoothing:
		smoothing_distance = 25 * r_button_rotation_speed # 0 - 25
		if smoothing_distance < 0.0:
			smoothing_distance = 0.0
		elif smoothing_distance > 25.0:
			smoothing_distance = 25.0
		var weight : float = float(smoothing_distance + 0.1) / 100
		_button_rotation = lerp(r_button.rotation_degrees, r_button_rotation_point, weight)
	else:
		_button_rotation = r_button_rotation_point
	
	r_button.rotation_degrees = _button_rotation


func r_button_rotation_speed_changer():
	# points | speed
	# 0      | 0
	# 1000   | 0.10
	# 10.000 | 0.20
	# 100k   | 0.40
	# 1kk    | 0.80
	# 70kk   | 1.0
	var _set_speed : float
	var _weight : float
	if click_points >= 70_000_000:
		_set_speed = 1.0
	elif click_points >= 1_000_000:
		_weight = log(click_points)/log(70_000_000)
		_set_speed = lerp(1.0/7, 1.0, _weight)
	elif click_points >= 100_000:
		_weight = float(click_points - 100_000) / 900_000
		_set_speed = snappedf(lerp(0.4, 0.8, _weight), 0.0001)
	elif click_points >= 10_000:
		_weight = float(click_points - 10_000) / 90_000
		_set_speed = snappedf(lerp(0.2, 0.4, _weight), 0.001)
	elif click_points >= 1000:
		_weight = float(click_points - 1000) / 9_000
		_set_speed = snappedf(lerp(0.1, 0.2, _weight), 0.001)
	else:
		_weight = log(click_points)/log(1000)
		_set_speed = snappedf(lerp(0.0, 0.1, _weight), 0.001)
		
	if _set_speed >= 1.0:
		_set_speed = 1.0
		r_button_rotation_speed = _set_speed
	elif r_button_rotation_speed < _set_speed:
		r_button_rotation_speed = _set_speed
	
	label_speed.text = str(r_button_rotation_speed)


func r_button_scale():
	var _button_scale : Vector2
	var smoothing_speed: float
	
	if game_smoothing:
		smoothing_speed = 5
		var weight : float = float(smoothing_speed) / 100
		_button_scale = lerp(r_button.scale, r_button_scale_point, weight)
	else:
		_button_scale = r_button_scale_point
		
	r_button.scale = _button_scale
