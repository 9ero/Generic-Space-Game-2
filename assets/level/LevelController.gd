extends Node2D



func _ready():
	$BgMusic.play()
	
func _physics_process(delta):
	get_node("Background").scroll_base_offset += Vector2(0, 1) * 8 * delta
	get_node("Clouds_1").scroll_base_offset += Vector2(0, 1) * 24 * delta
	get_node("Clounds_2").scroll_base_offset += Vector2(0, 1) * 34 * delta
	


