class_name PickUp
extends Area2D

@export var points = 0
@export var bounce_speed = 1.0
@export var bounce_scale = 1.0

var origin : Vector2
var rng = RandomNumberGenerator.new()
var bounce

func _ready():
	rng.randomize()
	#Animating the Pickup
	origin = global_position
	bounce = create_tween().set_trans(Tween.TRANS_SINE).bind_node(self)
	bounce.set_loops()
	bounce.tween_property(self, "position", origin + Vector2(0,bounce_scale), bounce_speed)
	bounce.chain().tween_property(self, "position", origin + Vector2(0,-bounce_scale), bounce_speed)
	bounce.custom_step(rng.randf() * 2.0 * bounce_scale)

func pickup(_body):
	Global.level.score += points
	$CollisionShape2D.disabled = true
	visible = false
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	queue_free()
	print("Picked Up!")

func _on_body_entered(body):
	call_deferred("pickup", body)
