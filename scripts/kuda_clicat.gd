extends Sprite2D

@onready var label = $"../Label"

var click_points : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(click_points)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var a : Vector2 = get_global_mouse_position()
	if Input.is_action_just_pressed("player_click"):
		click_points += 1
		label.text = str(click_points)
		self.area
	

