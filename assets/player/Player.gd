extends KinematicBody2D

export (PackedScene) var Shoot

const SPEED = 100
onready var motion = Vector2.ZERO
onready var can_shoot: bool = true
onready var screensize= get_viewport_rect().size


func _ready():
	$AnimatedSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	motion_controller()
	animation_controller()
	motion = move_and_collide(motion * delta)
	
func _input(event):
	if event.is_action_pressed("ui_accept") and can_shoot:
		shoot_controller()

func get_axis() -> Vector2:
	var axis= Vector2.ZERO #same to Vector2(0,0)
	axis.x = int(Input.is_action_pressed("ui_right"))- int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down"))- int(Input.is_action_pressed("ui_up"))
	return axis
	
func motion_controller():
	if get_axis() == Vector2.ZERO:
		motion= Vector2.ZERO
	else:
		motion = get_axis().normalized() * SPEED
	
	position.x= clamp(position.x, 0, screensize.x)
	position.y= clamp(position.y, 0, screensize.y)
	
func animation_controller():
	if get_axis().x ==1:
		$AnimatedSprite.animation = "Horizontal"
		$AnimatedSprite.flip_h = false
	elif get_axis().x == -1:
		$AnimatedSprite.animation = "Horizontal"
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.animation = "Vertical"

func shoot_controller():
	var shoot = Shoot.instance()
	shoot.global_position = $ShootSpawn.global_position
	get_tree().call_group("Level", "add_child", shoot)
