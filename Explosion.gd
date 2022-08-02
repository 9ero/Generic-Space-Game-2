extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()
	
	$SoundExplosion.play()

func _on_SoundExplosion_finished():
	queue_free()
